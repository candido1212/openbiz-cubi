<?php

include_once MODULE_PATH.'/websvc/lib/RestService.php';

class SystemRestService extends RestService
{
	protected $resourceDOMap = array('users'=>'system.do.UserDO');
}
?>