<?php

echo "<hr><h3>MySQLi</h3>";

$conn = new mysqli("db", "root", "root", "example");
$result = $conn->query("SELECT id, name, email FROM users");

while($row = $result->fetch_assoc()) {
  echo "<div>{$row['id']} <strong>{$row['name']}</strong> {$row['email']}</div><br>";
} $conn->close();

echo "<hr><h3>PDO</h3>";

$pdo = new PDO("mysql:host=db;dbname=example", "root", "root");
$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
$stmt = $pdo->query("SELECT id, name, email FROM users");

while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
  echo "<div>{$row['id']} <strong>{$row['name']}</strong> {$row['email']}</div><br>";
}
