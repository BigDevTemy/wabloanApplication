public function sendOTP($mobile_number){

        
        $client = new Client();
        $otp = $this->generateRandomNumber();
        $username = 'hademylola@gmail.com';
        $password='Ademilola2@';
        $sender='WabLoan';
        $message = "Thank you for choosing Wabloan\n Your OTP is ". $otp."\n This OTP expires in the next 20mins.\nWabLoan";
        
        
       

		try{
            $response = $client->request('GET', 'https://portal.nigeriabulksms.com/api', [
                
                'query' => [
                    "username" => $username,
                    "password" => $password,
                    "message" => $message,
                    "sender"=>'WabLoan',
                    "mobiles"=>$mobile_number,
                    
               ]

            ]);   	
     	 		$result =$response->getBody()->getContents();
           		return [json_decode($result),$otp,$response->getStatusCode()];
           	
           	
           	

                
          }
          catch(\GuzzleHttp\Exception\RequestException $e){
            $response = $e->getResponse();
            $responseBodyAsString = json_decode($response->getBody()->getContents());
            return[$responseBodyAsString];
          }

    }