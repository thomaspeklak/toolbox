<?php
/* This function provides a basic class autoload algorithm for a MVC architecture
 *
 * If the class name ends in Model, View or Controller (e.g. TestController) it loads
 * class definition from the models, views and controllers directory.
 */

function __autoload($class_name) {
	 switch (true){
		case substr($class_name,-5) == 'Model':
			require_once 'models/'.$class_name . '.php';
			break;
		case substr($class_name,-4) == 'View':
			require_once 'helpers/'.$class_name . '.php';
			break;
		case substr($class_name,-10) == 'Controller':
			require_once 'controllers/'.$class_name . '.php';
		}
}
?>