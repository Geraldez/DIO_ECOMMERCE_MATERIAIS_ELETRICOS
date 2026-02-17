-- MySQL Script refatorado para camelCase
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `ecommerce` DEFAULT CHARACTER SET utf8 ;
USE `ecommerce` ;

-- -----------------------------------------------------
-- Tabela `cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `dataCadastro` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `nome` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(250) NOT NULL,
  `enderecoCobranca` VARCHAR(250) NOT NULL,
  `enderecoEntrega` VARCHAR(250) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `clientePf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`clientePf` (
  `idCliente` INT NOT NULL,
  `cpf` CHAR(11) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `cpfUnique` (`cpf` ASC) VISIBLE,
  CONSTRAINT `fkClientePf`
    FOREIGN KEY (`idCliente`)
    REFERENCES `ecommerce`.`cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `clientePj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`clientePj` (
  `idCliente` INT NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `cnpjUnique` (`cnpj` ASC) VISIBLE,
  CONSTRAINT `fkClientePj`
    FOREIGN KEY (`idCliente`)
    REFERENCES `ecommerce`.`cliente` (`idCliente`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`pedido` (
  `idPedido` INT NOT NULL,
  `dataPedido` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `statusPedido` VARCHAR(45) NULL DEFAULT 'em processamento',
  `descricao` VARCHAR(45) NULL,
  `frete` DECIMAL(10,2) NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idPedido`),
  CONSTRAINT `fkPedidoCliente`
    FOREIGN KEY (`idCliente`)
    REFERENCES `ecommerce`.`cliente` (`idCliente`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`produto` (
  `idProduto` INT NOT NULL,
  `categoria` VARCHAR(45) NULL,
  `descricao` VARCHAR(45) NULL,
  `valor` DECIMAL(13,2) NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;

-- Tabela produto pedido
CREATE TABLE IF NOT EXISTS `ecommerce`.`produtoPedido` (
  `idProduto` INT NOT NULL,
  `idPedido` INT NOT NULL,
  `quantidade` INT NOT NULL,
  `valorUnitario` DECIMAL(13,2) NOT NULL,
  PRIMARY KEY (`idProduto`, `idPedido`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`fornecedor` (
  `idFornecedor` INT NOT NULL,
  `razaoSocial` VARCHAR(45) NOT NULL,
  `cnpj` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `cnpjFornecedorUnique` (`cnpj` ASC) VISIBLE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `produtoFornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`produtoFornecedor` (
  `idFornecedor` INT NOT NULL,
  `idProduto` INT NOT NULL,
  PRIMARY KEY (`idFornecedor`, `idProduto`),
  CONSTRAINT `fkProdFornFornecedor`
    FOREIGN KEY (`idFornecedor`)
    REFERENCES `ecommerce`.`fornecedor` (`idFornecedor`),
  CONSTRAINT `fkProdFornProduto`
    FOREIGN KEY (`idProduto`)
    REFERENCES `ecommerce`.`produto` (`idProduto`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`estoque` (
  `idEstoque` INT NOT NULL,
  `dataAtualizacao` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `localEstoque` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `itemEstoque` (Anteriormente qt_em_estoque)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`itemEstoque` (
  `idProduto` INT NOT NULL,
  `idEstoque` INT NOT NULL,
  `quantidade` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`idProduto`, `idEstoque`),
  CONSTRAINT `fkEstoqueProduto`
    FOREIGN KEY (`idProduto`)
    REFERENCES `ecommerce`.`produto` (`idProduto`),
  CONSTRAINT `fkEstoqueLocal`
    FOREIGN KEY (`idEstoque`)
    REFERENCES `ecommerce`.`estoque` (`idEstoque`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `formaPagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`formaPagamento` (
  `idFormaPagamento` INT NOT NULL AUTO_INCREMENT,
  `tipoPagamento` VARCHAR(45) NOT NULL, -- debito, credito, pix, etc
  `idPedido` INT NOT NULL,
  PRIMARY KEY (`idFormaPagamento`),
  CONSTRAINT `fkPagamentoPedido`
    FOREIGN KEY (`idPedido`)
    REFERENCES `ecommerce`.`pedido` (`idPedido`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Tabela `entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ecommerce`.`entrega` (
  `idEntrega` INT NOT NULL AUTO_INCREMENT,
  `statusEntrega` TINYINT NOT NULL COMMENT '0:Processando, 1:Enviado, 2:Entregue',
  `codigoRastreio` VARCHAR(20) NOT NULL,
  `idPedido` INT NOT NULL,
  `dataEnvio` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idEntrega`),
  CONSTRAINT `fkEntregaPedido`
    FOREIGN KEY (`idPedido`)
    REFERENCES `ecommerce`.`pedido` (`idPedido`)
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;