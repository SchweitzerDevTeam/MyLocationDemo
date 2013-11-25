<?php
    class SchweitzerMobileAppAPI {
        private $db;
        
        function __construct() {
            $this->db = new mysqli('ada.gonzaga.edu', 'eshioyama', 'eshioyama1234', 'schweitzerTest');
            $this->db->autocommit(FALSE);
        }
        
        function __destruct() {
            $this->db->close();
        }
        
        function getStatusCodeMessage($status) {
            $codes = Array(
                           200 => 'OK',
                           400 => 'Bad Request',
                           403 => 'Forbidden'
                           );
            
            return (isset($codes[$status])) ? $codes[$status] : '';
        }
        
        function sendResponse($status = 200, $body = '', $content_type = 'text/html') {
            $status_header = 'HTTP/1.1 ' . $status . ' ' . $this->getStatusCodeMessage($status);
            header($status_header);
            header('Content-type: ' . $content_type);
            echo $body;
        }
        
        function getVertSkied() {
            if (isset($_GET["username"])) {
                $username = $_GET["username"];
                $stmt = $this->db->prepare('SELECT SUM(v.verticalSkied) FROM test v JOIN junkID i USING (id) WHERE i.username=?');
                $stmt->bind_param("s", $username);
                $stmt->execute();
                $stmt->bind_result($vertftskied);
                $result = array();
                while ($stmt->fetch()) {
                    $result["verticalFeetSkied"] = $vertftskied;
                }
                $stmt->close();
                
                if (!isset($result["verticalFeetSkied"])) {
                    $this->sendResponse(400, 'Invalid user');
                    return false;
                }
                $this->sendResponse(200, $this->array_to_json($result));
                return true;
            }
            $this->sendResponse(400, 'Invalid request');
            return false;
        }
        
        function getDaysSkied() {
            if (isset($_GET["username"])) {
                $username = $_GET["username"];
                $stmt = $this->db->prepare('SELECT COUNT(*) FROM test v JOIN junkID i USING (id) WHERE i.username=?');
                $stmt->bind_param("s", $username);
                $stmt->execute();
                $stmt->bind_result($daysskied);
                $result = array();
                while ($stmt->fetch()) {
                    $result["daysSkied"] = $daysskied;
                }
                $stmt->close();
                
                if ($result["daysSkied"] === 0) {
                    $this->sendResponse(400, 'Invalid user');
                    return false;
                }
                $this->sendResponse(200, $this->array_to_json($result));
                return true;
            }
            $this->sendResponse(400, 'Invalid request');
            return false;
        }
        
        function postUserData(){
            
            if(isset($_POST["username"]) && $_POST["vertftski"])
            {
                /* the functions below set the time zone and then date just
                 grabs the current date from the server. We can also do this
                 for the current time, time(), this will probably be useful for the /
                 */
                date_default_timezone_set('America/Los_Angeles');
                $date = date('Y-m-d');
                $username = $_POST["username"];
                $vertftski = $_POST["vertftski"];
                
                $stmt = $this->db->prepare('SELECT id FROM junkID WHERE username=?');
                $stmt->bind_param("s", $username);
                $stmt->execute();
                $stmt->bind_result($userid);
                $idresult;
                while ($stmt->fetch()) {
                    $idresult = $userid;
                }
                if (!$idresult) {
                    $this->sendResponse(400, 'Invalid username');
                    $stmt->close();
                    return false;
                }
                $stmt->close();
                
                $stmt = $this->db->prepare('INSERT INTO test VALUES (?, ?, ?)');
                $stmt->bind_param("iss", $idresult, $vertftski, $date);
                $stmt->execute();
                if (!($stmt->error === '')){
                    if (substr($stmt->error, 0, 15) === "Duplicate entry") {
                        $this->sendResponse(403, $stmt->error);
                        return false;
                    }
                    $this->sendResponse(400, 'Error while inserting: ' . $stmt->error);
                    $stmt->close();
                    return false;
                }
                $stmt->close();
                
                $this->sendResponse(200, 'Table Updated');
                return true;
            }
            $this->sendResponse(400, 'Invalid Request: failed update');
            return false;
        }
        
        function updateUserVert()
        {
            if(isset($_POST["username"]) && $_POST["vertftski"])
            {
                $username = $_POST["username"];
                $vertftski = $_POST["vertftski"];
                
                date_default_timezone_set('America/Los_Angeles');
                $date = date('Y-m-d');
                
                $stmt = $this->db->prepare('SELECT id FROM junkID WHERE username=?');
                $stmt->bind_param("s", $username);
                $stmt->execute();
                $stmt->bind_result($userid);
                $idresult;
                while ($stmt->fetch()) {
                    $idresult = $userid;
                }
                if (!$idresult) {
                    $this->sendResponse(400, 'Invalid username');
                    $stmt->close();
                    return false;
                }
                $stmt->close();
                
                $stmt = $this->db->prepare('UPDATE test SET verticalSkied=? WHERE id=? AND dateSkied=?');
                $stmt->bind_param("sss", $vertftski, $userid, $date);
                $stmt->execute();
                
                if(!($stmt->error === ''))
                {
                    $this->sendResponse(400, $stmt->error);
                    return false;
                }
                $this->sendResponse(200,'User vertical feet skied has been updated');
                return true;
            }
            sendResponse(400, 'Invalid Request: invalid parameters');
            return false;
        }
        
        function array_to_json( $array ){
            
            if( !is_array( $array ) ){
                return false;
            }
            
            $associative = count( array_diff( array_keys($array), array_keys( array_keys( $array )) ));
            if( $associative ){
                
                $construct = array();
                foreach( $array as $key => $value ){
                    
                    // We first copy each key/value pair into a staging array,
                    // formatting each key and value properly as we go.
                    
                    // Format the key:
                    if( is_numeric($key) ){
                        $key = "key_$key";
                    }
                    $key = '"'.addslashes($key).'"';
                    
                    // Format the value:
                    if( is_array( $value )){
                        $value = array_to_json( $value );
                    } else if( !is_numeric( $value ) || is_string( $value ) ){
                        $value = '"'.addslashes($value).'"';
                    }
                    
                    // Add to staging array:
                    $construct[] = "$key: $value";
                }
                
                // Then we collapse the staging array into the JSON form:
                $result = "{ " . implode( ", ", $construct ) . " }";
                
            } else { // If the array is a vector (not associative):
                
                $construct = array();
                foreach( $array as $value ){
                    
                    // Format the value:
                    if( is_array( $value )){
                        $value = array_to_json( $value );
                    } else if( !is_numeric( $value ) || is_string( $value ) ){
                        $value = '"'.addslashes($value).'"';
                    }
                    
                    // Add to staging array:
                    $construct[] = $value;
                }
                
                // Then we collapse the staging array into the JSON form:
                $result = "[ " . implode( ", ", $construct ) . " ]";
            }
            
            return $result;
        }
    }
    
    ?>