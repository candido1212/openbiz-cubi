<?php 
class WorklogReportStatDO extends BizDataObj
{
	
	public function fetch()
	{		
		if($this->m_SearchRule){
			$this->m_SearchRule = str_replace("[chart_type]  = :_v1", "", $this->m_SearchRule);		
		}
		
		//get stat data for avg level
		if($this->m_SearchRule)
		{
				$searchRule = $this->m_SearchRule;
		}else{
				$searchRule = "";
		}				
		$rows = parent::directFetch($searchRule);
		if(count($rows))
		{
			$row = $rows[0];
			$create_date = date("Y-m-d",strtotime($row['create_time']));
			$month = date("Y-m",strtotime($row['create_time']));
			$month_days = date("t",$create_date);
		} 		
		$dataset_avg = array();
		foreach($rows as $row)
		{
			$create_date = date("Y-m-d",strtotime($row['create_time']));
			$dataset_avg[$create_date] = $row;
		}		
		
		
		//get stat data for my data
		$my_user_id = BizSystem::getUserProfile("Id");
		if($searchRule)
		{
				$searchRule .= " AND [create_by]='$my_user_id' ";
		}else{
				$searchRule = " [create_by]='$my_user_id' ";
		}
		$rows = parent::directFetch($searchRule);
		$dataset_mine = array();
		foreach($rows as $row)
		{
			$create_date = date("Y-m-d",strtotime($row['create_time']));
			$dataset_mine[$create_date] = $row;
		}
		
		$resultSet = array();
		for($i=1;$i<=$month_days;$i++)
		{			
			$record = array();
			$day = sprintf("%02d",$i);
			$new_date = $month.'-'.$day;
			$record['Id'] = strtotime($new_date);
			$record['date'] = $new_date;
			$record['date_d'] = (int)date('d',strtotime($new_date));
			$record['workhour_avg']	= (int)$dataset_avg[$new_date]['data_count'];
			$record['workhour_mine']= (int)$dataset_mine[$new_date]['data_count'];
			$resultSet[] = $record;
		}
		return $resultSet;
	}
	

	
}
?>