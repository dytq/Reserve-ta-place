<html>
	<head>
		<title>Se connecter</title>
	</head>
	<body>
		<form method="POST" action="connecte.php">
			<table>
				<tr>
				<td>email : </td>
				<td><input type="text" name="email"></td>
				</tr>
				<tr>
				<td>Mot de passe : </td>
				<td><input type="password" name="mdp"></td>
				</tr>
			</table>
			<input type="Submit" value="Se connecter"><input type="reset">
			<?php
				if(isset($_GET['not'])) {
					$not = $_GET['not'];
					if ($not == 1){
							print "<div id=\"email\">email ou mot de passe incorrect</div>";
					}
				}
			?>
		</form>
	</body>
</html>
