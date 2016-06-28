<?php

class AppBuilderController extends CI_Controller {

	public function __construct()
	{
		parent::__construct();
		//$this->load->database();
        $this->load->model('appBuilderModel');
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

		echo $this->appBuilderModel->saveObject($objectData);
	}

	public function getObject() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		echo $this->appBuilderModel->getObject($objectData);
	}

	public function getCreateObject() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		echo $this->appBuilderModel->getCreateObject($objectData);
	}

	public function updateCreateObject() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		echo $this->appBuilderModel->updateCreateObject($objectData);
	}

	public function updateObject() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		echo $this->appBuilderModel->updateObject($objectData);
	}

	public function deleteObject() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		echo $this->appBuilderModel->deleteObject($objectData);
	}

	public function count() {
		$objectData = json_decode(file_get_contents('php://input'), true);

		echo $this->appBuilderModel->count($objectData);
	}

	public function prueba() {
		echo getcwd();

		copy('https://img21.taquilla.com/data/images/t/d0/fiestas-en-ibiza__330x275.jpg', 'public/file.jpg');

		echo 'ok';
	}
}
?>