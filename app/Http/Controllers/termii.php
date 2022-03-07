$curl = curl_init();
		$data = array("to" => "2349072419909","from" => "Wabloan",
		"sms"=>$message,"type" => "plain","channel" => "generic","api_key" => "TLqcjIeX9CMBYW4iHAqzqaoYZcIGIUilPxWlNZc4tyiFSPmJzsTLdvT1WQlZjm",  );

		$post_data = json_encode($data);

		curl_setopt_array($curl, array(
		  CURLOPT_URL => "https://termii.com/api/sms/send",
		  CURLOPT_RETURNTRANSFER => true,
		  CURLOPT_ENCODING => "",
		  CURLOPT_MAXREDIRS => 10,
		  CURLOPT_TIMEOUT => 0,
		  CURLOPT_FOLLOWLOCATION => true,
		  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
		  CURLOPT_CUSTOMREQUEST => "POST",
		  CURLOPT_POSTFIELDS => $post_data,
		  CURLOPT_HTTPHEADER => array(
		    "Content-Type: application/json"
		  ),
		));

		$response = curl_exec($curl);
		curl_close($curl);
		return  $response;