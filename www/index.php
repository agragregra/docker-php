<?php

$conn = new mysqli("db", "root", "root", "example");
$result = $conn->query("SELECT id, name, email FROM users");

while($row = $result->fetch_assoc()) {
  echo "<div>{$row['id']} <strong>{$row['name']}</strong> {$row['email']}</div>";
}

$conn->close();
