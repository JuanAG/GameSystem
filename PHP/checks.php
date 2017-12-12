<?php

    function checkNameValid($name){
        $answer = "ok";

        if(strlen($name) > 50){
            $answer = formNameTooLong;
        }

        return $answer;
    }

    function checkLastNameValid($lastName){
        $answer = "ok";

        if(strlen($lastName) > 50){
            $answer = formLastNameTooLong;
        }

        return $answer;
    }

    function checkAddressValid($address){
        $answer = "ok";

        if(strlen($address) > 250){
            $answer = formAddressTooLong;
        }

        return $answer;
    }

    function checkCPValid($cp){
        $answer = "ok";

        if($cp < 0 || $cp > 100000){
            $answer = formCPError;
        }

        return $answer;
    }

    function checkDNIValid($dni){
        $answer = "ok";

        if(strlen($dni) > 20 ){
            $answer = formDNITooLong;
        }

        else {
            $word = substr($dni, -1);
            $number = substr($dni, 0, -1);
            if (substr("TRWAGMYFPDXBNJZSQVHLCKE", $number%23, 1) == $word && strlen($word) == 1 && strlen ($number) == 8){

            }else{
                $answer = formDNIError;
            }
        }

        return $answer;
    }

    function checkMailValid($mail){
        $answer = "ok";

        if(strlen($mail) > 250){
            $answer = formMailTooLong;
        }
        else if(!filter_var($mail, FILTER_VALIDATE_EMAIL)){
            $answer = formMailError;
        }
        else if((getCountMails($mail))['COUNT'][0] != 0){
            $answer = formMailNotUnique;
        }

        return $answer;
    }

    function checkLoginValid($login){
        $answer = "ok";

        if(strlen($login) > 100){
            $answer = formLoginTooLong;
        }
        else if((getCountUsers($login))['COUNT'][0] != 0){
            $answer = formLoginNotUnique;
        }

        return $answer;
    }

    function checkLoginValid2($login){
        $answer = "ok";

        if(strlen($login) > 100){
            $answer = formLoginTooLong;
        }

        return $answer;
    }

    function checkPassValid($pass){
        $answer = "ok";

        if(strlen($pass) > 100){
            $answer = formPassTooLong;
        }

        return $answer;
    }

