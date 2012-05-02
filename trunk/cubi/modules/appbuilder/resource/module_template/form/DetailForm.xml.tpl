<?xml version="1.0" encoding="UTF-8"?>
<EasyForm Name="{$form_short_name}" Class="{$form_obj_class}" FormType="" jsClass="jbForm" Title="{$module_name|replace:'_':' '|capitalize} Detail" Description="" BizDataObj="{$comp}.{$do_name}" TemplateEngine="Smarty" TemplateFile="detail_elementset.tpl" EventName="{$event_name}" MessageFile="{$message_file}">
    <DataPanel>
{foreach from=$fields item=fld}
{if $fld.name != 'Id' && $fld.name != 'create_by' && $fld.name != 'create_time' && $fld.name != 'update_by' && $fld.name != 'update_time'  }
       	<Element Name="fld_{$fld.name}" ElementSet="General" Class="LabelText" FieldName="{$fld.name}" Label="{$fld.name|replace:'_':' '|capitalize}" AllowURLParam="{if $fld.name eq 'Id'}Y{else}N{/if}"/>
{elseif $fld.name == 'create_by' || $fld.name == 'update_by'}
       	<Element Name="fld_{$fld.name}" Class="LabelText" ElementSet="Miscellaneous" FieldName="{$fld.name}" Label="{$fld.name|replace:'_':' '|capitalize}" Text="{literal}{{/literal}BizSystem::GetProfileName(@:Elem[fld_{$fld.name}].Value){literal}}{/literal}" AllowURLParam="N"/>       	
{elseif $fld.name == 'create_time' || $fld.name == 'update_time'}
       	<Element Name="fld_{$fld.name}" Class="LabelText" ElementSet="Miscellaneous" FieldName="{$fld.name}" Label="{$fld.name|replace:'_':' '|capitalize}"  AllowURLParam="N"/>       	
{else}
		<Element Name="fld_{$fld.name}" ElementSet="General" Hidden="Y" Class="LabelText" FieldName="{$fld.name}" Label="{$fld.name|replace:'_':' '|capitalize}" AllowURLParam="{if $fld.name eq 'Id'}Y{else}N{/if}"/>
{/if}
{/foreach}
    </DataPanel>
    <ActionPanel>       
        <Element Name="btn_new" Class="Button" Text="Add" CssClass="button_gray_add" Description="new record (Insert)">
			<EventHandler Name="btn_new_onclick" Event="onclick" Function="SwitchForm({$comp}.{$new_form})"  ShortcutKey="Insert" ContextMenu="New" />
        </Element>          
        <Element Name="btn_edit" Class="Button" Text="Edit" CssClass="button_gray_m" Description="edit record (Ctrl+E)">
			<EventHandler Name="btn_new_onclick" Event="onclick" Function="SwitchForm({$comp}.{$edit_form},{literal}{@:Elem[fld_Id].Value}{/literal})"  ShortcutKey="Ctrl+E" ContextMenu="Edit" />
        </Element>
		<Element Name="btn_copy" Class="Button" Text="Copy" CssClass="button_gray_m" Description="copy record (Ctrl+C)">
            <EventHandler Name="onclick" Event="onclick" EventLogMsg="" Function="CopyRecord({literal}{@:Elem[fld_Id].Value}{/literal})" RedirectPage="form={$comp}.{$copy_form}&amp;fld:Id={literal}{@:Elem[fld_Id].Value}{/literal}" ShortcutKey="Ctrl+C" ContextMenu="Copy"/>
        </Element> 
        <Element Name="btn_delete" Class="Button" Text="Delete" CssClass="button_gray_m" Description="delete record (Delete)">
            <EventHandler Name="del_onclick" Event="onclick" EventLogMsg="" Function="DeleteRecord({literal}{@:Elem[fld_Id].Value}{/literal})"  RedirectPage="form={$comp}.{$list_form}" ShortcutKey="Ctrl+Delete" ContextMenu="Delete" />
        </Element>
        <Element Name="btn_cancel" Class="Button" Text="Back" CssClass="button_gray_m">
            <EventHandler Name="btn_cancel_onclick" Event="onclick" Function="SwitchForm()"  ShortcutKey="Escape" ContextMenu="Cancel" />
        </Element>         
    </ActionPanel> 
    <NavPanel>
    </NavPanel> 
    <SearchPanel>
    </SearchPanel>
</EasyForm>