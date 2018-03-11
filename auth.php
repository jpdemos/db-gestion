<?php

//------------
$SRV_PAGE_AUTH	= ""; // relatif a la position du fichier

$SRV_USERNAME	= "";
$SRV_PASSWORD	= "";
$SRV_DTBNAME	= "PARIS";

class DatabaseConnection
{
	private $pdo, $personnelQuery, $personnel;

	function __construct()
	{
		try
		{
			//mysql:host=localhost
			$this->pdo = new PDO( "sqlsrv:Server=localhost;Database=" . $SRV_DTBNAME, $SRV_USERNAME, $SRV_PASSWORD )
		}
		catch( Exception $e )
		{
			die( '[DatabaseConnection] Erreur lors de la construction: ' . $e->getMessage() );
		}

		// on prepare la query car elle sera utilisé plusieurs fois
		$this->personnelQuery = $this->pdo->prepare( "SELECT * FROM PERSONNEL" )
		$this->updatePersonnel();
	}

	function close()
	{
		$this = null;
	}

	function updatePersonnel() // mise a jours de la table des personnel
	{
		$this->personnel = $this->personnelQuery->execute();
		$this->personnel = $this->personnel->fetchAll();
	}

	function getPersonnel()
	{
		$this->updatePersonnel();

		return $this->personnel;
	}

	function query( $sql )
	{
		return $this->pdo->query( $sql );
	}

}

$SRV_DBCO = new DatabaseConnection();
//------------

//Authentification: pour modif profile
class Authentification
{
	private $login, $mdp, $db;

	function __construct( $l, $mdp, $db = $SRV_DBCO )
	{
		$this->login	= $l or "invalid";
		$this->mdp		= $mdp or "invalid";
		$this->db		= $db;
	}


	function login()
	{
		if( !isset( $_SESSION ) or $_SESSION[ "logged" ] ) { return; } // si session_start() n'as pas été apellé ou si on est déjà logged in -> return

		foreach( $this->db->getPersonnel() as $personnel )
		{
			if( $personnel[ "login" ]	== $this->login and
				$personnel[ "mdp" ]		== $this->mdp )
			{
				// on peux log in
				$_SESSION[ "logged" ] = true;
				$_SESSION[ "authObj" ] = $this; // pour pouvoir logout
				$_SESSION[ "profile" ] = new Profile( $this->db, $personnel ); // création du profile

				break;
			}
		}
		// rediriger

		// session_start(); sur toutes les pages de tests *.php
	}

	function logout()
	{
		if( isset( $_SESSION ) )
		{
			$_SESSION[ "logged" ] = false;

			unset( $_SESSION[ "profile" ] );
			unset( $_SESSION[ "authObj" ] );
		}

		//retour page auth / acceuil

	}

}


//Profile: pour avoir les affecations, etc
class Profile
{
	private $nom, $prenom, $matricule, $niveau; //etc
	private $db;

	function __construct( $db, $infos )
	{
		$this->db = $db or $SRV_DBCO;
		$this->buildProfile( $infos );
	}

	function buildProfile( $infos )
	{
		$request = $this->db->query(
			"SELECT P.nom, P.prenom, P.matricule, T.nivIntervention
			FROM PERSONNEL P, TECHNICIEN T
			WHERE P.idPersonnel = T.idPersonnel AND T.idPersonnel = " . $infos[ "idPersonnel" ] );

		foreach ($request as $rowId => $values) {
			
		}
		

		$this->nom			= $infos[ "nom" ];
		$this->prenom		= $infos[ "prenom" ];
		$this->matricule	= $infos[ "matricule" ];
		$this->nivInterv	= $infos[ "nivIntervention" ];

		//?
	}

	function getTickets()
	{
		// recup les tickets et leur type et état (array)
	}

	function getAffectations()
	{
		// recup les affectations (par rapport au niveau) avec $_SESSION et $SRV_DBCO
		/* genre:
			{
				[1] = {pcname, pb, activityHistory, ...}
			}
		*/
	}
}

?>