<?php
define("TOKEN", "`p+23049diqowedqhd++ç!ª!·", TRUE);
define("PRIVATEKEY", "dnuehjbdq834+ç´`", TRUE);

class ParseQLController extends CI_Controller {

	public function __construct()
	{
		parent::__construct();
		//$this->load->database();
        $this->load->model('parseQLModel');
	}

	/*public function coordinates() {
		$lat = 40.034093;
		$lng = 0.333345345;
		$kilometers = 100;

		$this->db->select("*, ( 6371 * acos( cos( radians($lat) ) * cos( radians( Latitud ) ) * cos( radians( Longitud ) - radians($lng) ) + sin( radians($lat) ) * sin( radians( Latitud ) ) ) ) AS distance");                         
		$this->db->having('distance <= ' . $kilometers);                     
		$this->db->order_by('distance');                    
		$this->db->limit(20, 0);

		$queryDist = $this->db->get('listaPueblos');

		foreach($queryDist->result_array() as $pueblo) {
			echo $pueblo['Poblacion'].'<br>';
		}
	}*/

	public function configDatabase() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		$db['default']['hostname'] = $objectData['hostname'];
		$db['default']['database'] = $objectData['database'];
		$db['default']['username'] = $objectData['username'];
		$db['default']['password'] = $objectData['password'];
	}

	public function saveObject() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		//DESENCRYPTION
		$encryptedData = $objectData["encryptedData"];
		$desencryptedJson = json_decode($this->encryptedByteArrayToString($encryptedData), true);

		if ($desencryptedJson["token"] == TOKEN) {
			unset($desencryptedJson["token"]);
			//MODEL
			$encryptedResponse = $this->parseQLModel->saveObject($desencryptedJson);
			echo json_encode(array(
				"encryptedData" => $this->stringToEncryptedByteArray($encryptedResponse)
			));
		}
		else {
			echo json_encode(array(
				"encryptedData" => array("Resp" => "INVALID TOKEN")
			));
		}
	}

	public function getObject() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		$objectData = json_decode(file_get_contents('php://input'), true);

		//DESENCRYPTION
		$encryptedData = $objectData["encryptedData"];
		$desencryptedJson = json_decode($this->encryptedByteArrayToString($encryptedData), true);

		if ($desencryptedJson["token"] == TOKEN) {
			unset($desencryptedJson["token"]);
			//MODEL
			$encryptedResponse = $this->parseQLModel->getObject($objectData);
			echo json_encode(array(
				"encryptedData" => $this->stringToEncryptedByteArray($encryptedResponse)
			));
		}
		else {
			echo json_encode(array(
				"encryptedData" => array("Resp" => "INVALID TOKEN")
			));
		}
	}

	public function getCreateObject() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		$objectData = json_decode(file_get_contents('php://input'), true);

		//DESENCRYPTION
		$encryptedData = $objectData["encryptedData"];
		$desencryptedJson = json_decode($this->encryptedByteArrayToString($encryptedData), true);

		if ($desencryptedJson["token"] == TOKEN) {
			unset($desencryptedJson["token"]);
			//MODEL
			$encryptedResponse = $this->parseQLModel->getCreateObject($objectData);
			echo json_encode(array(
				"encryptedData" => $this->stringToEncryptedByteArray($encryptedResponse)
			));
		}
		else {
			echo json_encode(array(
				"encryptedData" => array("Resp" => "INVALID TOKEN")
			));
		}
	}

	public function updateCreateObject() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		$objectData = json_decode(file_get_contents('php://input'), true);

		//DESENCRYPTION
		$encryptedData = $objectData["encryptedData"];
		$desencryptedJson = json_decode($this->encryptedByteArrayToString($encryptedData), true);

		if ($desencryptedJson["token"] == TOKEN) {
			unset($desencryptedJson["token"]);
			//MODEL
			$encryptedResponse = $this->parseQLModel->updateCreateObject($objectData);
			echo json_encode(array(
					"encryptedData" => $this->stringToEncryptedByteArray($encryptedResponse)
				));
		}
		else {
			echo json_encode(array(
				"encryptedData" => array("Resp" => "INVALID TOKEN")
			));
		}
	}

	public function updateObject() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		$objectData = json_decode(file_get_contents('php://input'), true);

		//DESENCRYPTION
		$encryptedData = $objectData["encryptedData"];
		$desencryptedJson = json_decode($this->encryptedByteArrayToString($encryptedData), true);

		if ($desencryptedJson["token"] == TOKEN) {
			unset($desencryptedJson["token"]);
			//MODEL
			$encryptedResponse = $this->parseQLModel->updateObject($objectData);
			echo json_encode(array(
					"encryptedData" => $this->stringToEncryptedByteArray($encryptedResponse)
				));
		}
		else {
			echo json_encode(array(
				"encryptedData" => array("Resp" => "INVALID TOKEN")
			));
		}
	}

	public function deleteObject() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		$objectData = json_decode(file_get_contents('php://input'), true);

		//DESENCRYPTION
		$encryptedData = $objectData["encryptedData"];
		$desencryptedJson = json_decode($this->encryptedByteArrayToString($encryptedData), true);

		if ($desencryptedJson["token"] == TOKEN) {
			unset($desencryptedJson["token"]);
			//MODEL
			$encryptedResponse = $this->parseQLModel->deleteObject($objectData);
			echo json_encode(array(
				"encryptedData" => $this->stringToEncryptedByteArray($encryptedResponse)
			));
		}
		else {
			echo json_encode(array(
				"encryptedData" => array("Resp" => "INVALID TOKEN")
			));
		}
	}

	public function count() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		$objectData = json_decode(file_get_contents('php://input'), true);

		//DESENCRYPTION
		$encryptedData = $objectData["encryptedData"];
		$desencryptedJson = json_decode($this->encryptedByteArrayToString($encryptedData), true);

		if ($desencryptedJson["token"] == TOKEN) {
			unset($desencryptedJson["token"]);
			//MODEL
			$encryptedResponse = $this->parseQLModel->count($objectData);
			echo json_encode(array(
				"encryptedData" => $this->stringToEncryptedByteArray($encryptedResponse)
			));
		}
		else {
			echo json_encode(array(
				"encryptedData" => array("Resp" => "INVALID TOKEN")
			));
		}
	}

	public function prueba() {
		echo getcwd();

		copy('https://img21.taquilla.com/data/images/t/d0/fiestas-en-ibiza__330x275.jpg', 'public/img/fiestas/file.jpg');

		echo 'ok';
	}

	public function saveObjectTest() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		//DESENCRYPTION
		$encryptedData = $objectData["encryptedData"];
		$desencryptedJson = json_decode($this->encryptedByteArrayToString($encryptedData), true);

		//ENCRYPTION
		$tableName = $desencryptedJson["tableName"];
		echo json_encode(array(
			"encryptedData" => $this->stringToEncryptedByteArray($tableName)
		));
	}

	public function encryptedByteArrayToString($byteArray) { //DESENCRYPT
		$keyArray = unpack("C*", PRIVATEKEY);

		$resultString = "";

		$i = 1;
		foreach ($byteArray as $char) {

			$xor = $char ^ $keyArray[$i];

			$resultString .= chr($xor);

			$i++;
			if ($i >= count($keyArray)+1) {
				$i = 1;
			}
		}

		return $resultString;
	}

	public function stringToEncryptedByteArray($string) { //ENCRYPT
		$stringArray = unpack("C*", $string);
		$keyArray = unpack("C*", PRIVATEKEY);

		$resultArray = array();


		$i = 1;
		foreach ($stringArray as $char) {

			$xor = $char ^ $keyArray[$i];

			$resultArray[] = $xor;

			$i++;
			if ($i >= count($keyArray)) {
				$i = 1;
			}
		}

		return implode($resultArray, ',');
	}
}
?>