-- MySQL Script generated by MySQL Workbench
-- Sun Nov 27 20:53:53 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `idCClientePF` INT NOT NULL,
  `idCClientePJ` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `idCClientePF`, `idCClientePJ`),
  INDEX `fk_Cliente_Cliente PJ1_idx` (`idCClientePJ` ASC),
  INDEX `fk_Cliente_Cliente PF1_idx` (`idCClientePF` ASC),
  CONSTRAINT `fk_Cliente_Cliente PJ1`
    FOREIGN KEY (`idCClientePJ`)
    REFERENCES `mydb`.`Cliente PJ` (`idClientePJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Cliente PF1`
    FOREIGN KEY (`idCClientePF`)
    REFERENCES `mydb`.`Cliente PF` (`idClientePF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente PF`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente PF` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente PF` (
  `idClientePF` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  `Data de Nascimento` DATE NOT NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  `Cidade` VARCHAR(45) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  `Telefone 1` CHAR(11) NOT NULL,
  `Telefone 2` CHAR(11) NULL,
  `E-mail 1` VARCHAR(45) NOT NULL,
  `E-mail 2` VARCHAR(45) NULL,
  PRIMARY KEY (`idClientePF`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente PJ`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente PJ` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente PJ` (
  `idClientePJ` INT NOT NULL,
  `Razão Social` VARCHAR(45) NOT NULL,
  `Nome Fantasia` VARCHAR(45) NOT NULL,
  `CNPJ` CHAR(14) NOT NULL,
  `Responsavel` VARCHAR(45) NOT NULL,
  `Telefone 1` CHAR(11) NOT NULL,
  `Telefone 2` INT NULL,
  `E-mail 1` VARCHAR(45) NOT NULL,
  `E-mail 2` VARCHAR(45) NULL,
  `Endereço Empresarial` VARCHAR(45) NOT NULL,
  `Cidade` VARCHAR(45) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  PRIMARY KEY (`idClientePJ`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Equipes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Equipes` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Equipes` (
  `idEquipes` INT NOT NULL,
  `Especialidade` ENUM('Motor', 'Suspensão', 'Eletrica', 'Carroceria') NOT NULL,
  `Responsavel` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEquipes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estoque de Peças`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Estoque de Peças` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Estoque de Peças` (
  `idEstoque_pecas` INT NOT NULL AUTO_INCREMENT,
  `Nome peça` VARCHAR(45) NOT NULL,
  `Quantidade Disponivel` INT NOT NULL,
  `Valor Unitário` FLOAT NOT NULL,
  `Responsavel` VARCHAR(45) NOT NULL,
  `Funcionario Solicitante` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEstoque_pecas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Funcionarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Funcionarios` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Funcionarios` (
  `idFuncionarios` INT NOT NULL AUTO_INCREMENT,
  `idFEquipes` INT NOT NULL,
  `Código` CHAR(6) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `CPF` CHAR(11) NOT NULL,
  `Data de Nascimento` DATE NOT NULL,
  `Endereço` VARCHAR(45) NOT NULL,
  `CEP` CHAR(8) NOT NULL,
  `Cidade` VARCHAR(45) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  `Cargo` VARCHAR(45) NOT NULL,
  `Especialidade` VARCHAR(45) NOT NULL,
  `Data de Contratação` DATE NOT NULL,
  `Telefone` INT NOT NULL,
  PRIMARY KEY (`idFuncionarios`, `idFEquipes`),
  INDEX `fk_Funcionarios_Equipes1_idx` (`idFEquipes` ASC),
  CONSTRAINT `fk_Funcionarios_Equipes1`
    FOREIGN KEY (`idFEquipes`)
    REFERENCES `mydb`.`Equipes` (`idEquipes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orçamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Orçamento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Orçamento` (
  `idOrcamento` INT NOT NULL AUTO_INCREMENT,
  `idOCliente` INT NOT NULL,
  `Numero do Orçamento` VARCHAR(45) NOT NULL,
  `Aprovado Pelo Cliente` ENUM('Sim', 'Não') NOT NULL,
  `Data do Orçamento` DATE NOT NULL,
  `Valor do Orçamento` FLOAT NOT NULL,
  `Validade do Orçamento` DATE NOT NULL,
  PRIMARY KEY (`idOrcamento`, `idOCliente`),
  INDEX `fk_Orçamento_Cliente1_idx` (`idOCliente` ASC),
  CONSTRAINT `fk_Orçamento_Cliente1`
    FOREIGN KEY (`idOCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ordem de Serviço`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ordem de Serviço` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Ordem de Serviço` (
  `idOrdem_servico` INT NOT NULL AUTO_INCREMENT,
  `idOSVeiculo` INT NOT NULL,
  `idOSEquipes` INT NOT NULL,
  `idOSOrçamento` INT NOT NULL,
  `Numero` CHAR(8) NOT NULL,
  `Data da Emissão` DATE NOT NULL,
  `pecas_necessarias` VARCHAR(45) NULL,
  `Valor` FLOAT NULL,
  `Status_ordem` ENUM('Em execução', 'Concluida', 'Em analise pela equipe') NOT NULL DEFAULT 'Em execução',
  `Data para conclusão` DATE NOT NULL,
  PRIMARY KEY (`idOrdem_servico`, `idOSVeiculo`, `idOSEquipes`, `idOSOrçamento`),
  INDEX `fk_Ordem de Serviço_Equipes1_idx` (`idOSEquipes` ASC),
  INDEX `fk_Ordem de Serviço_Veiculo1_idx` (`idOSVeiculo` ASC),
  INDEX `fk_Ordem de Serviço_Orçamento1_idx` (`idOSOrçamento` ASC),
  CONSTRAINT `fk_Ordem de Serviço_Equipes1`
    FOREIGN KEY (`idOSEquipes`)
    REFERENCES `mydb`.`Equipes` (`idEquipes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Serviço_Veiculo1`
    FOREIGN KEY (`idOSVeiculo`)
    REFERENCES `mydb`.`Veiculo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Serviço_Orçamento1`
    FOREIGN KEY (`idOSOrçamento`)
    REFERENCES `mydb`.`Orçamento` (`idOrcamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Peças para OS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Peças para OS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Peças para OS` (
  `idPecas_Estoque_pecas` INT NOT NULL,
  `idPecas_Ordem_servico` INT NOT NULL,
  `idPecas_OSOrçamento` INT NOT NULL,
  PRIMARY KEY (`idPecas_Estoque_pecas`, `idPecas_Ordem_servico`, `idPecas_OSOrçamento`),
  INDEX `fk_Estoque de Peças_has_Ordem de Serviço_Ordem de Serviç_idx` (`idPecas_Ordem_servico` ASC, `idPecas_OSOrçamento` ASC),
  INDEX `fk_Estoque de Peças_has_Ordem de Serviço_Estoque de Peça_idx` (`idPecas_Estoque_pecas` ASC),
  CONSTRAINT `fk_Estoque de Peças_has_Ordem de Serviço_Estoque de Peças1`
    FOREIGN KEY (`idPecas_Estoque_pecas`)
    REFERENCES `mydb`.`Estoque de Peças` (`idEstoque_pecas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estoque de Peças_has_Ordem de Serviço_Ordem de Serviço1`
    FOREIGN KEY (`idPecas_Ordem_servico` , `idPecas_OSOrçamento`)
    REFERENCES `mydb`.`Ordem de Serviço` (`idOrdem_servico` , `idOSOrçamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Precos_orcamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Precos_orcamento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Precos_orcamento` (
  `idPO_Orcamento` INT NOT NULL,
  `idPO_Tabela_precos` INT NOT NULL,
  PRIMARY KEY (`idPO_Orcamento`, `idPO_Tabela_precos`),
  INDEX `fk_Orçamento_has_Tabela de Preços_Tabela de Preços1_idx` (`idPO_Tabela_precos` ASC),
  INDEX `fk_Orçamento_has_Tabela de Preços_Orçamento1_idx` (`idPO_Orcamento` ASC),
  CONSTRAINT `fk_Orçamento_has_Tabela de Preços_Orçamento1`
    FOREIGN KEY (`idPO_Orcamento`)
    REFERENCES `mydb`.`Orçamento` (`idOrcamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orçamento_has_Tabela de Preços_Tabela de Preços1`
    FOREIGN KEY (`idPO_Tabela_precos`)
    REFERENCES `mydb`.`Tabela de Preços` (`idTabela_precos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tabela de Preços`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Tabela de Preços` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Tabela de Preços` (
  `idTabela_precos` INT NOT NULL AUTO_INCREMENT,
  `Tipo do Serviço` ENUM('Revisão', 'Conserto') NOT NULL,
  `Especialidade` ENUM('Motor', 'Suspensão', 'Escapamento', 'Carroceria') NOT NULL,
  `Peças Necessárias` VARCHAR(45) NOT NULL,
  `Quantidade de Peças` FLOAT NOT NULL,
  `Preco_peca` FLOAT NULL,
  `Valor mão de Obra` FLOAT NOT NULL,
  `Valor_total` FLOAT NOT NULL,
  PRIMARY KEY (`idTabela_precos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Veiculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Veiculo` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Veiculo` (
  `idVeiculo` INT NOT NULL AUTO_INCREMENT,
  `idVCliente` INT NOT NULL,
  `Tipo de Veiculo` ENUM('Moto', 'Carro', 'Triciclo', 'Van', 'Caminhão') NOT NULL,
  `Placa` CHAR(7) NOT NULL,
  `Marca` VARCHAR(45) NOT NULL,
  `Modelo` VARCHAR(45) NOT NULL,
  `Ano de Fabricação` CHAR(4) NOT NULL,
  PRIMARY KEY (`idVeiculo`, `idVCliente`),
  INDEX `fk_Veiculo_Cliente1_idx` (`idVCliente` ASC),
  CONSTRAINT `fk_Veiculo_Cliente1`
    FOREIGN KEY (`idVCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
