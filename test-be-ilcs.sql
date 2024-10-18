/*
 Navicat Premium Data Transfer

 Source Server         : test-BE-ILCS
 Source Server Type    : MySQL
 Source Server Version : 80030 (8.0.30)
 Source Host           : localhost:3306
 Source Schema         : test-be-ilcs

 Target Server Type    : MySQL
 Target Server Version : 80030 (8.0.30)
 File Encoding         : 65001

 Date: 18/10/2024 10:09:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for header
-- ----------------------------
DROP TABLE IF EXISTS `header`;
CREATE TABLE `header`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `no_pengajuan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nama_pengaju` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `tgl_pengajuan` date NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of header
-- ----------------------------
INSERT INTO `header` VALUES (10, '20210922FDF20240172000022', 'Alice Smith', '2024-10-19');
INSERT INTO `header` VALUES (11, '20210922FDF20240172000023', 'Bob Johnson', '2024-10-20');
INSERT INTO `header` VALUES (12, '20210922FDF20240172000024', 'Charlie Brown', '2024-10-21');

-- ----------------------------
-- Table structure for pungutan
-- ----------------------------
DROP TABLE IF EXISTS `pungutan`;
CREATE TABLE `pungutan`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_header` int NULL DEFAULT NULL,
  `incoterms` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `valuta` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `kurs` decimal(10, 4) NOT NULL,
  `nilai` decimal(15, 2) NOT NULL,
  `biaya_tambahan` decimal(15, 2) NULL DEFAULT NULL,
  `biaya_pengurangan` decimal(15, 2) NULL DEFAULT NULL,
  `voluntary_declaration` decimal(15, 2) NULL DEFAULT NULL,
  `nilai_fob` decimal(15, 2) NULL DEFAULT NULL,
  `asuransi` decimal(15, 2) NULL DEFAULT NULL,
  `freight` decimal(15, 2) NULL DEFAULT NULL,
  `cif` decimal(15, 2) NULL DEFAULT NULL,
  `cif_rp` decimal(20, 2) NULL DEFAULT NULL,
  `bruto` decimal(15, 2) NULL DEFAULT NULL,
  `netto` decimal(15, 2) NULL DEFAULT NULL,
  `flag_kontainer` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id_header`(`id_header` ASC) USING BTREE,
  CONSTRAINT `pungutan_ibfk_1` FOREIGN KEY (`id_header`) REFERENCES `header` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of pungutan
-- ----------------------------
INSERT INTO `pungutan` VALUES (6, 10, 'Cost and Freight', 'Euro', 17000.0000, 200000.00, 1000.00, 500.00, 0.00, 200500.00, 800.00, 3000.00, 204300.00, 3473100000.00, 1200.50, 1150.75, 'Kontainer');
INSERT INTO `pungutan` VALUES (7, 11, 'Free on Board', 'US Dollar', 16200.0000, 150000.00, 200.00, 1000.00, 500.00, 149700.00, 600.50, 4500.00, 154800.50, 2507768100.00, 900.25, 850.80, 'Cargo Curah');
INSERT INTO `pungutan` VALUES (8, 12, 'Cost, Insurance and Freight', 'Pound Sterling', 19000.0000, 250000.00, 1500.00, 250.00, 1000.00, 252250.00, 750.00, 5000.00, 258000.00, 4902000000.00, 1300.75, 1250.45, 'Kontainer');

SET FOREIGN_KEY_CHECKS = 1;
