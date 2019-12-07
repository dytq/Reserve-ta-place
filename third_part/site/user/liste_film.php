<?php
	print "<html><head><title>Film</title></head><body>";
	
	$link = new mysqli("localhost", "Anonyme", "anonyme");
	if($link->connect_errno) {
		    die ("Erreur de connexion : errno: " . $link->errno . " error: "  . $link->error);
	}
	
	$link->select_db('Projet') or die("Erreur de selection de la BD: " . $link->error);
	
	$query = "Select F.*, avg(N.note) as moyenne from Film F, Note N where N.num_film = F.num_film group by F.num_film order by moyenne DESC;";
	$result = $link->query($query) or die("erreur select");
	
	print "<table>";
	while ($tuple = mysqli_fetch_object($result)){ 
		print "
			<tr>
			<td>image</td>
			<td><a href=\"film.php?num_film=$tuple->num_film\">$tuple->nom</a><br>
			Note : $tuple->moyenne</td>
			</tr>";
	}
	print "</table>";
	
	$link->close();
	
	print "</body></html>";
?>