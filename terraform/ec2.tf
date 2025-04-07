resource "aws_security_group" "wordpress-sg" {
  name        = "wordpress-sg"
  vpc_id      = aws_vpc.new-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "wordpress-sg"
  }
}

resource "aws_instance" "wordpress" {
  ami           = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnets[0].id
  vpc_security_group_ids = [aws_security_group.wordpress-sg.id]

  user_data = <<-EOF
              #!/bin/bash
              # Atualizar o sistema
              apt-get update
              apt-get upgrade -y
              
              # Instalar Apache, PHP e MySQL
              apt-get install -y apache2 php php-mysql mysql-server php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip
              
              # Iniciar e habilitar serviços
              systemctl start apache2
              systemctl enable apache2
              systemctl start mysql
              systemctl enable mysql
              
              # Configurar MySQL
              mysql -e "CREATE DATABASE wordpress;"
              mysql -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY 'wordpress_password';"
              mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'localhost';"
              mysql -e "FLUSH PRIVILEGES;"
              
              # Baixar e configurar WordPress
              cd /var/www/html
              rm -rf *
              wget https://wordpress.org/latest.tar.gz
              tar -xzvf latest.tar.gz
              mv wordpress/* .
              rm -rf wordpress latest.tar.gz
              
              # Criar arquivo wp-config.php
              cat > wp-config.php << 'EOL'
              <?php
              define('DB_NAME', 'wordpress');
              define('DB_USER', 'wordpress');
              define('DB_PASSWORD', 'wordpress_password');
              define('DB_HOST', 'localhost');
              define('DB_CHARSET', 'utf8');
              define('DB_COLLATE', '');
              define('AUTH_KEY',         'hihUIEDAEUS');
              define('SECURE_AUTH_KEY',  'DNTUjnBRIUSd');
              define('LOGGED_IN_KEY',    'jbBWPKMnenJ');
              define('NONCE_KEY',        'HSDBCIkjbiuBIR');
              define('AUTH_SALT',        'SVJ4KJVJKVSLKjjd');
              define('SECURE_AUTH_SALT', 'jUOIihraOIHhvO');
              define('LOGGED_IN_SALT',   'uhUHEuhuWods');
              define('NONCE_SALT',       'IknceIEmceeEFNB');
              $table_prefix = 'wp_';
              define('WP_DEBUG', false);
              if (!defined('ABSPATH')) {
                  define('ABSPATH', __DIR__ . '/');
              }
              require_once ABSPATH . 'wp-settings.php';
              EOL
              
              # Configurar permissões
              chown -R www-data:www-data /var/www/html
              chmod -R 755 /var/www/html
              
              # Reiniciar Apache
              systemctl restart apache2
              EOF

  tags = {
    Name = "${var.prefix}-wordpress"
  }
}

output "wordpress_public_ip" {
  value = aws_instance.wordpress.public_ip
} 