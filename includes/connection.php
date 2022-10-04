<?php
class Connection
{
	// This contains the connection
	private $db;

	// Query variables
	private $strQuery;
	private $arrValues;

	// Connection variables
	private string $db_drvr = driver;
	private string $db_host = host;
	private string $db_port = port;
	private string $db_dbnm = dbase;
	private string $db_user = uname;
	private string $db_pass = pass;
	private string $db_chrt = chart;

	// Connection to the Database
	protected function __construct()
	{
		$connectionString = $this->db_drvr.":host=".$this->db_host.":".$this->db_port."; dbname=".$this->db_dbnm."; charset=".$this->db_chrt;

		try {
			$this->db = new PDO($connectionString, $this->db_user, $this->db_pass);
			$this->db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
		} catch (PDOException $e) {
			echo "Error: " . $e->getMessage();
		}
		return $this->db;
	}
	
	// Function to insert a register
	protected function insert(string $query, array $array)
	{
		$this->strQuery = $query;
		$this->arrValues = $array;

		$query_insert = $this->db->prepare($this->strQuery);
		$result_insert = $query_insert->execute($this->arrValues);

		if ($result_insert) {
			$last_Insert = $this->db->lastInsertId();
		} else {
			$last_Insert = 0;
		}
		return $last_Insert;
	}

	// Function to perform a query
	protected function select(string $query)
	{
		$this->strQuery = $query;
		$result_select = $this->db->prepare($this->strQuery);
		$result_select->execute();
		$data = $result_select->fetch(PDO::FETCH_ASSOC);
		return $data;
	}

	// Function to select all records in the table
	protected function select_all(string $query)
	{
		$this->strQuery = $query;
		$result_select_all = $this->db->prepare($this->strQuery);
		$result_select_all->execute();
		$data = $result_select_all->fetchAll(PDO::FETCH_ASSOC);
		return $data;
	}

	// Function to update a register
	protected function update(string $query, array $array)
	{
		$this->strQuery = $query;
		$this->arrValues = $array;
		$update = $this->db->prepare($this->strQuery);
		$result_update = $update->execute($this->arrValues);
		return $result_update;
	}

	// Function to delete a record
	protected function delete(string $query)
	{
		$this->strQuery = $query;
		$delete = $this->db->prepare($this->strQuery);
		$result_delete = $delete->execute();
		return $result_delete;
	}
}
