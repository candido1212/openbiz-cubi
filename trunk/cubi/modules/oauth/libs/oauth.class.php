<?php
/**
 * Openbiz Cubi Application Platform
 *
 * LICENSE http://code.google.com/p/openbiz-cubi/wiki/CubiLicense
 *
 * @package   cubi.service
 * @copyright Copyright (c) 2005-2011, Openbiz Technology LLC
 * @license   http://code.google.com/p/openbiz-cubi/wiki/CubiLicense
 * @link      http://code.google.com/p/openbiz-cubi/
 * @version   $Id: oauthService.php 3371 2012-05-31 06:17:21Z rockyswen@gmail.com $
 */

class oauthClass extends EasyForm
{
	/**
	 * 
	 * OAuth type 
	 * e.g.: Taobao or Facebook etc..
	 * @var string
	 */
	protected $m_Type;
		
	/**
	 * 
	 * Temperary cache provider data
	 * @var array
	 */
	protected $m_ProviderData;
		
	/**
	 * 
	 * Data Object for storage users oauth token info
	 * @var string
	 */
	protected $m_UserOAuthDO;
 
	protected $m_Providers;
 
	protected $m_oauthProviderDo='oauth.do.OauthProviderDO';
	
	
    function __construct()
    {
         
    } 

    
	/**
	 * 
	 * Get OAuth provider data including api_key, api_secret, url etc
	 * @return array;
	 */	
	
	public function getProviderList()
	{
	  	 $recArr=BizSystem::sessionContext()->getVar("_OAUTH_{$this->m_Type}");
		 if(!$recArr)
			 {
			 $do=BizSystem::getObject($this->m_oauthProviderDo);
			 $sql="SELECT `type` ,  `key` ,  `value`  FROM  `{$do->m_MainTable}` where status=1 and type='{$this->m_Type}' LIMIT 0 , 1 ";
			 $db=$do->getDBConnection();
			 $recArr=$db->fetchAssoc($sql);
			 BizSystem::sessionContext()->setVar("_OAUTH_{$this->m_Type}",$recArr);
		 }
		 return $recArr;
	}
	

	/**
	 * 
	 * abstract functions need to be implement in sub class
	 * Validate if the oauth info still available 
	 * @param intger $user_id
	 * @param intger $oauth_id
	 * @return bool
	 */	
	public function validateUserOAuth($user_id,$oauth_id){}
	
	/**
	 * 
	 * avstract function to check given oauth_data is valid or not
	 * @param array oauth_data
	 * @return bool
	 */
	public function check($oauth_data){

		if(!$oauth_data['id'])
		{
			throw new Exception('Unknown oauth_token');
			return;
		}
		$UserTokenObj = BizSystem::getObject('oauth.do.UserTokenDO');
		$UserToken=$UserTokenObj->fetchOne("type_uid='".$oauth_data['id']."'");
		$oauth_data['oauth_token']=$_SESSION[$this->m_Type]['access_token']['oauth_token'] ; 
		$oauth_data['oauth_token_secret']=$_SESSION[$this->m_Type]['access_token']['oauth_token_secret']; 

		if($UserToken)
		{
			global $g_BizSystem; 
			$userObj = BizSystem::getObject('system.do.UserDO');
			$userinfo=$userObj->fetchOne("id='".$UserToken['user_id']."'");
			$UserOAuthArr['oauth_token']=$oauth_data['oauth_token'];
			$UserOAuthArr['oauth_token_secret']=$oauth_data['oauth_token_secret'];
			$UserTokenObj->updateRecords($UserOAuthArr); 
			$profile=$g_BizSystem->InituserProfile($userinfo['username']);
			//获取当前用户角色的默认页
			$index=$profile['roles'][0];  
			$roleStartpage=$rec_info['roleStartpage'][$index];
			$redirectPage = APP_INDEX.$roleStartpage;
			BizSystem::clientProxy()->ReDirectPage($redirectPage);
		}
		else
		{	
			//未找到用户，跳转到注册页
			BizSystem::sessionContext()->setVar('_OauthUserInfo',$oauth_data);
			header("Location: ./bin/controller.php?view=user.view.RegisterView");
		}
		 	return $profile;
	}
	
	
	public function saveUserOAuth($user_id, $oauth_data)
	{
		
	}

	public function clearUserOAuth($user_id, $oauth_id)
	{
		
	}

	public function getUserOAuthList($user_id)
	{
		
	}
	/*
	 This method will used for redirect to 3rd party platform login page
	*/
	public function login(){
	
	}
	
	public function getUserOauth(){
	
	}
	public function getUserInfo(){
	
	}

}
?>