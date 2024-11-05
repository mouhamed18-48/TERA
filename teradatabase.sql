CREATE TABLE `consommateur` (
  `consommateur_firstname` varchar(255) NOT NULL,
  `consommateur_secondname` varchar(255) NOT NULL,
  `consommateur_phone` varchar(15) NOT NULL,
  `consommateur_password` varchar(255) NOT NULL
) ;
CREATE TABLE `entrepot` (
  `entrepot_id` varchar(6) NOT NULL,
  `entrepot_nom` varchar(255) NOT NULL,
  `entrepot_adresse` varchar(255) NOT NULL,
  `entrepot_latitude` double NOT NULL,
  `entrepot_longitude` double NOT NULL,
  `entrepot_capacite_total` bigint NOT NULL,
  `contact` varchar(15) NOT NULL
) ;
INSERT INTO `entrepot` (`entrepot_id`, `entrepot_nom`, `entrepot_adresse`, `entrepot_latitude`, `entrepot_longitude`, `entrepot_capacite_total`, `contact`) VALUES
('AQ1N5W', 'Yeumbeul', 'Yeumbeul', 24, -13, 12069, '777177171'),
('ASF542', 'Keur Massar', 'Keur Massar', 14.5, -34, 11000, '777177171'),
('HGDG51', 'Pikine', 'Pikine', 91, -32, 386367, '777177171');


CREATE TABLE `entrepotproduit` (
  `entrepot_id` varchar(6) DEFAULT NULL,
  `produit_type` varchar(255) NOT NULL,
  `capacite` double NOT NULL
) ;

INSERT INTO `entrepotproduit` (`entrepot_id`, `produit_type`, `capacite`) VALUES
('AQ1N5W', 'cacahuete', 0),
('ASF542', 'carotte', 0),
('ASF542', 'patate', 0),
('ASF542', 'cacahuete', 0),
('AQ1N5W', 'carotte', 0),
('AQ1N5W', 'patate', 0),
('HGDG51', 'cacahuete', 0),
('HGDG51', 'carotte', 0),
('HGDG51', 'patate', 0);



CREATE TABLE `gerant` (
  `gerant_id` varchar(6) NOT NULL,
  `gerant_name` varchar(255) NOT NULL,
  `gerant_entrepot` varchar(255) NOT NULL,
  `gerant_password` varchar(255) NOT NULL
) ;

CREATE TABLE `producter` (
  `producter_firstname` varchar(255) NOT NULL,
  `producter_secondname` varchar(255) NOT NULL,
  `producter_phone` varchar(15) NOT NULL,
  `producter_password` varchar(255) NOT NULL
) ;

CREATE TABLE `production` (
  `nombre_produit` int NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `producteur_phone` varchar(15) NOT NULL
) ;
CREATE TABLE `produit` (
  `produit_type` varchar(255) NOT NULL,
  `produit_tarif` double NOT NULL,
  `produit_prix` double NOT NULL
) ;

INSERT INTO `produit` (`produit_type`, `produit_tarif`, `produit_prix`) VALUES
('cacahuete', 30, 500),
('carotte', 50, 500),
('patate', 40, 500);

CREATE TABLE `produitProducteur` (
  `produit_type` varchar(255) NOT NULL,
  `producter_phone` varchar(15) NOT NULL
);


CREATE TABLE `reservation` (
  `res_id` varchar(6) NOT NULL,
  `res_producteur` varchar(15) NOT NULL,
  `res_entrepot` varchar(6) NOT NULL,
  `res_produit` varchar(255) NOT NULL,
  `res_datetime_validation` datetime DEFAULT NULL,
  `estDeposer` int NOT NULL DEFAULT '0',
  `res_quantite` bigint NOT NULL,
  `encours` int NOT NULL DEFAULT '1',
  `reservation_duree` int NOT NULL,
  `livraison` int NOT NULL DEFAULT '0'
) ;

CREATE TABLE `reservation_update` (
  `res_id` varchar(6) NOT NULL,
  `res_producteur` varchar(15) NOT NULL,
  `res_entrepot` varchar(6) NOT NULL,
  `res_produit` varchar(255) NOT NULL,
  `res_datetime_validation` datetime DEFAULT NULL,
  `estDeposer` int NOT NULL DEFAULT '0',
  `res_quantite` bigint NOT NULL,
  `encours` int NOT NULL DEFAULT '1',
  `reservation_duree` int NOT NULL,
  `livraison` int NOT NULL DEFAULT '0'
) ;
CREATE TABLE `vente` (
  `vente_id` varchar(6) NOT NULL,
  `vente_produit` varchar(255) NOT NULL,
  `vente_quantite` varchar(255) NOT NULL,
  `vente_prix` bigint NOT NULL,
  `vente_encour` int NOT NULL,
  `vente_datetime_validation` datetime DEFAULT NULL,
  `addresse` varchar(100) NOT NULL,
  `numero` varchar(15) NOT NULL,
  `vente_consommateur` varchar(15) NOT NULL
) ;

ALTER TABLE `consommateur`
  ADD PRIMARY KEY (`consommateur_phone`);

ALTER TABLE `entrepot`
  ADD PRIMARY KEY (`entrepot_id`);

ALTER TABLE `entrepotproduit`
  ADD UNIQUE KEY `entrepot_id` (`entrepot_id`,`produit_type`),
  ADD KEY `produit_type` (`produit_type`);

ALTER TABLE `gerant`
  ADD PRIMARY KEY (`gerant_id`);

ALTER TABLE `producter`
  ADD PRIMARY KEY (`producter_phone`);

ALTER TABLE `production`
  ADD PRIMARY KEY (`producteur_phone`);

ALTER TABLE `produit`
  ADD PRIMARY KEY (`produit_type`);


ALTER TABLE `produitProducteur`
  ADD PRIMARY KEY (`produit_type`,`producter_phone`),
  ADD KEY `producter_phone` (`producter_phone`);

ALTER TABLE `reservation`
  ADD PRIMARY KEY (`res_id`),
  ADD KEY `res_producteur` (`res_producteur`),
  ADD KEY `res_entrepot` (`res_entrepot`),
  ADD KEY `res_produit` (`res_produit`);

--
-- Indexes for table `reservation_update`
--
ALTER TABLE `reservation_update`
  ADD PRIMARY KEY (`res_id`);

--
-- Indexes for table `vente`
--
ALTER TABLE `vente`
  ADD PRIMARY KEY (`vente_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `entrepotproduit`
--
ALTER TABLE `entrepotproduit`
  ADD CONSTRAINT `entrepotproduit_ibfk_1` FOREIGN KEY (`entrepot_id`) REFERENCES `entrepot` (`entrepot_id`),
  ADD CONSTRAINT `entrepotproduit_ibfk_2` FOREIGN KEY (`produit_type`) REFERENCES `produit` (`produit_type`);

--
-- Constraints for table `production`
--
ALTER TABLE `production`
  ADD CONSTRAINT `production_ibfk_1` FOREIGN KEY (`producteur_phone`) REFERENCES `producter` (`producter_phone`);

--
-- Constraints for table `produitProducteur`
--
ALTER TABLE `produitProducteur`
  ADD CONSTRAINT `produitproducteur_ibfk_1` FOREIGN KEY (`producter_phone`) REFERENCES `producter` (`producter_phone`);

--
-- Constraints for table `reservation`
--
ALTER TABLE `reservation`
  ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`res_producteur`) REFERENCES `producter` (`producter_phone`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`res_entrepot`) REFERENCES `entrepot` (`entrepot_id`),
  ADD CONSTRAINT `reservation_ibfk_3` FOREIGN KEY (`res_produit`) REFERENCES `produit` (`produit_type`);


DELIMITER $$

CREATE PROCEDURE ReduceQuantity(
 IN in_res_producteur VARCHAR(15),
    IN in_res_entrepot VARCHAR(6),
    IN in_res_produit VARCHAR(255),
    IN quantite INT
)
BEGIN
    DECLARE total_to_remove INT DEFAULT quantite;
    DECLARE current_id VARCHAR(6);
    DECLARE current_quantity INT;
    DECLARE done INT DEFAULT 0;

    -- Cursor to iterate over the rows
    DECLARE cur CURSOR FOR
        SELECT ⁠ res_id ⁠, ⁠ res_quantite ⁠
        FROM ⁠ reservation_update ⁠
        WHERE ⁠ res_quantite ⁠ > 0 AND res_producteur=in_res_producteur AND res_entrepot = in_res_entrepot AND estDeposer=1 AND encours=1
        ORDER BY ⁠ res_quantite ⁠ DESC;

    -- Declare the handler for when the cursor is exhausted
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN cur;

    read_loop: LOOP
        -- Fetch the current row
        FETCH cur INTO current_id, current_quantity;
        
        -- Exit loop if no more rows
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        -- Check if we can remove the total needed
        IF current_quantity >= total_to_remove THEN
            -- Update the row with the reduced quantity
            UPDATE ⁠ reservation_update ⁠
            SET ⁠ res_quantite ⁠ = ⁠ res_quantite ⁠ - total_to_remove
            WHERE ⁠ res_id ⁠ = current_id;
            
            -- Set total_to_remove to 0 as we've removed all needed
            SET total_to_remove = 0;
            
            -- Exit the loop as the requirement is satisfied
            LEAVE read_loop;
        ELSE
            -- Subtract what we can and move to the next row
            UPDATE ⁠ reservation_update ⁠
            SET ⁠ res_quantite ⁠ = 0
            WHERE ⁠ res_id ⁠ = current_id;
            
            -- Decrease total_to_remove by the current quantity
            SET total_to_remove = total_to_remove - current_quantity;
        END IF;
        
        -- Continue to next row
    END LOOP;

    -- Close the cursor
    CLOSE cur;
END $$

DELIMITER ;