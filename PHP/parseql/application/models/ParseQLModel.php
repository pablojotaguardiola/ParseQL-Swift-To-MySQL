<?php

class ParseQLModel extends CI_Model {

	public function __construct()
	{
		$this->load->database();
		$this->load->dbforge();
	}

	//SAVE
	public function saveObject($objectData) {
		$tableName = $objectData['tableName'];
		$fieldsDictionary = $objectData['fieldsDictionary'];

		//CHECK TABLE EXISTS, IF NOT, CREATE
		if (!$this->db->table_exists($tableName)) {
			$this->dbforge->add_field('id');

			$this->dbforge->create_table($tableName);
		}

		//CHECK FIELDS EXISTS, IF NOT, CREATE
		$fields = array();
		foreach($fieldsDictionary as $key => $value) {
			if (!$this->db->field_exists($key, $tableName)) {
				$fields[$key] = $this->getFieldType($value);
			}
		}

		$this->dbforge->add_column($tableName, $fields);

		$this->db->insert($tableName, $fieldsDictionary);

		return json_encode(array('Resp' => 'ok'));
	}

	//GET
	public function getObject($objectData) {
		$result = array();
		$tableName = $objectData['tableName'];

		if ($this->db->table_exists($tableName)) {
			$whereDictionary = $objectData['whereDictionary'];
			$limit = $objectData['limit'];
			$skip = $objectData['skip'];

			//DISTANCE
			if (isset($objectData['distance'])) {
				$kmDistance = $objectData['distance'];
				$lat = $objectData['latitude'];
				$lng = $objectData['longitude'];
				$this->db->select("*, ( 6350 * acos( cos( radians($lat) ) * cos( radians( Latitud ) ) * cos( radians( Longitud ) - radians($lng) ) + sin( radians($lat) ) * sin( radians( Latitud ) ) ) ) AS distance");                         
				$this->db->having('distance <= ' . $kmDistance);  
				$this->db->order_by('distance');                   
			}

			//ORDERBY
			if (isset($objectData['orderByAsc'])) {
				$this->db->order_by($objectData['orderByAsc'], "asc");
			} else if (isset($objectData['orderByDesc'])) {
				$this->db->order_by($objectData['orderByDesc'], "desc");
			}

			//WHERE CONDITIONS
			if (count($whereDictionary) > 0) {
				$query = $this->db->get_where($tableName, $whereDictionary, $limit, $skip);
			}
			else {
				$query = $this->db->get($tableName, $limit, $skip);
			}

			foreach($query->result() as $row) {
				array_push($result, $row);
			}
		}

		return json_encode(array("Resp" => $result));
	}

	//GET OR CREATE
	public function getCreateObject($objectData) {
		$result = array();
		$tableName = $objectData['tableName'];
		$whereDictionary = $objectData['whereDictionary'];
		$fieldsDictionary = $objectData['fieldsDictionary'];
		
		$limit = $objectData['limit'];
		$skip = $objectData['skip'];

		//DISTANCE
		if (isset($objectData['distance'])) {
			$kmDistance = $objectData['distance'];
			$lat = $objectData['latitude'];
			$lng = $objectData['longitude'];
			$this->db->select("*, ( 6350 * acos( cos( radians($lat) ) * cos( radians( Latitud ) ) * cos( radians( Longitud ) - radians($lng) ) + sin( radians($lat) ) * sin( radians( Latitud ) ) ) ) AS distance");                         
			$this->db->having('distance <= ' . $kmDistance);  
			$this->db->order_by('distance');                   
		}

		//ORDERBY
		if (isset($objectData['orderByAsc'])) {
			$this->db->order_by($objectData['orderByAsc'], "asc");
		} else if (isset($objectData['orderByDesc'])) {
			$this->db->order_by($objectData['orderByDesc'], "desc");
		}

		//WHERE CONDITIONS
		if (count($whereDictionary) > 0) {
			$query = $this->db->get_where($tableName, $whereDictionary, $limit, $skip);
		}
		else {
			$query = $this->db->get($tableName, $limit, $skip);
		}

		if ($query->num_rows() == 0) {
			$this->db->insert($tableName, $fieldsDictionary);
			$newRow = $this->db->get_where($tableName, array('id' => $this->db->insert_id()));

			return json_encode(array('Resp' => array($newRow->first_row())));
		}
		else {
			foreach($query->result() as $row) {
				array_push($result, $row);
			}

			return json_encode(array("Resp" => $result));
		}
	}

	//UPDATE
	public function updateObject($objectData) {
		$result = array();

		$tableName = $objectData['tableName'];

		if ($this->db->table_exists($tableName)) {

			$whereDictionary = $objectData['whereDictionary'];
			$fieldsToSet = $objectData['fieldsToSet'];

			//WHERE CONDITIONS
			if (count($whereDictionary) > 0) {
				$this->db->where($whereDictionary);
				$this->db->update($tableName, $fieldsToSet);
				$result['affectedRows'] = $this->db->affected_rows();
			}
			else {
				$result['affectedRows'] = 0;
			}
		}

		return json_encode(array("Resp" => $result));
	}

	public function updateCreateObject($objectData) {
		$result = array();

		$tableName = $objectData['tableName'];

		if (!$this->db->table_exists($tableName)) {
			$this->saveObject($objectData);
		}

		$whereDictionary = $objectData['whereDictionary'];
		$fieldsToSet = $objectData['fieldsToSet'];

		//WHERE CONDITIONS
		if (count($whereDictionary) > 0) {
			$this->db->where($whereDictionary);
			$this->db->update($tableName, $fieldsToSet);
			$result['affectedRows'] = $this->db->affected_rows();
		}
		else {
			$result['affectedRows'] = 0;
		}

		if ($result['affectedRows'] == 0) {
			//Create Object
			$this->saveObject($objectData);
		}

		return json_encode(array("Resp" => $result));
	}

	public function deleteObject($objectData) {
		$result = array();

		$tableName = $objectData['tableName'];

		if ($this->db->table_exists($tableName)) {
			$whereDictionary = $objectData['whereDictionary'];
			
			//WHERE CONDITIONS
			if (count($whereDictionary) > 0) {
				$this->db->delete($tableName, $whereDictionary);
				$result['affectedRows'] = $this->db->affected_rows();
			}
			else {
				$result['affectedRows'] = 0;
			}	
		}	

		return json_encode(array("Resp" => $result));
	}

	//COUNT
	public function count($objectData) {
		$result = array();
		$tableName = $objectData['tableName'];

		if ($this->db->table_exists($tableName)) {
			$whereDictionary = $objectData['whereDictionary'];

			//DISTANCE
			if (isset($objectData['distance'])) {
				$kmDistance = $objectData['distance'];
				$lat = $objectData['latitude'];
				$lng = $objectData['longitude'];
				$this->db->select("*, ( 6350 * acos( cos( radians($lat) ) * cos( radians( Latitud ) ) * cos( radians( Longitud ) - radians($lng) ) + sin( radians($lat) ) * sin( radians( Latitud ) ) ) ) AS distance");                         
				$this->db->having('distance <= ' . $kmDistance);  
				$this->db->order_by('distance');                   
			}

			//WHERE CONDITIONS
			if (count($whereDictionary) > 0) {
				$query = $this->db->get_where($tableName, $whereDictionary);
			}
			else {
				$query = $this->db->get($tableName);
			}
		}

		return json_encode(array("Resp" => array("affectedRows" => $query->num_rows())));
	}

	private function getFieldType($value) {
		$response = array();
		if (is_int($value)) {
			$response = array(
            	"type" => "INT"
       		);
		}
		else {
			$response = array(
            	"type" => "TEXT"
       		);
		}
	}
}
?>