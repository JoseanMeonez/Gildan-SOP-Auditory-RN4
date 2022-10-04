<?php
class statusModel extends Connection
{
	// Get Status for General Use
	public function getStatus()
	{
		$query = "SELECT * FROM tblstatus WHERE stt_id >= 1 AND stt_id <= 2";
		$request = $this->select_all($query);

		return $request;
	}
}
