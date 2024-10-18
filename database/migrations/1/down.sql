PRAGMA user_version = 0;

DROP TABLE Configuration;
DROP TABLE Configuration_time_series_files;
DROP TABLE RenewablePlant;
DROP TABLE RenewablePlant_time_series_files;
DROP TABLE RenewablePlant_time_series_parameters;
DROP TABLE HydroPlant;
DROP TABLE HydroPlant_time_series_files;
DROP TABLE HydroPlant_time_series_parameters;
DROP TABLE GaugingStation;
DROP TABLE GaugingStation_time_series_historical_inflow;
DROP TABLE ThermalPlant;
DROP TABLE ThermalPlant_time_series_parameters;
DROP TABLE Demand;
DROP TABLE Demand_time_series_files;
DROP TABLE Zone;
DROP TABLE Bus;
DROP TABLE DCLine;
DROP TABLE DCLine_time_series_parameters;
DROP TABLE Branch;
DROP TABLE Branch_time_series_parameters;
DROP TABLE Battery;
DROP TABLE Battery_time_series_parameters;
DROP TABLE AssetOwner;
DROP TABLE AssetOwner_vector_markup;
DROP TABLE BiddingGroup;
DROP TABLE BiddingGroup_vector_markup;
DROP TABLE BiddingGroup_time_series_files;
DROP TABLE VirtualReservoir;
DROP TABLE VirtualReservoir_vector_owner_and_allocation;
DROP TABLE VirtualReservoir_vector_hydro_plant;
DROP TABLE Reserve;
DROP TABLE Reserve_time_series_files;
DROP TABLE Reserve_vector_thermal_plant;
DROP TABLE Reserve_vector_hydro_plant;
DROP TABLE Reserve_vector_battery;