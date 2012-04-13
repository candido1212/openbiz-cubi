<form id='{$form.name}' name='{$form.name}' style="border-bottom:2px solid #ABC3D7;border-top:2px solid #4E8CCF;">
<h2 class="title">{$form.title}</h2>
<div  class="listform">
<table width=100% cellspacing=0 cellpadding=2>
<tr>
<td colspan=9>
   <table cellspacing=2 cellpadding=0>
   <tr>
   {foreach item=elem from=$searchPanel}
     <td>{if $elem.label} {$elem.label} {/if} {$elem.element}</td>
   {/foreach}
   </tr>
   </table>
</td>
</tr>
<tr>
<td width=50% align=left>
   <table cellspacing=2 cellpadding=0>
   <tr>
   {foreach item=elem from=$actionPanel}
     <td>{$elem.element}</td>
   {/foreach}
   <td><div id='{$form.name}.load_disp' style="display:none"><img src="../images/indicator.white.gif"/></div></td>
   </tr>
   </table>
</td>
<td width=50% align=right>
{if $navPanel}
   <table cellspacing=2 cellpadding=1>
   <tr>
   {foreach item=elem from=$navPanel}
     <td>{$elem.element}</td>
   {/foreach}
   </tr>
   </table>
{/if}
</td>
</tr>
<tr>
<td colspan=9>
   <div id="{$form.name}_data">
   <table width=100% border=0 bgcolor=#D9D9D9 cellspacing=0 cellpadding=3 class="tbl">

     <tr>
     {foreach item=cell from=$dataPanel.elems}
         <th class=head>{$cell.label}</th>
     {/foreach}
     </tr>

     {assign var=counter value=0}
     
     {foreach item=row from=$dataPanel.data}
         {if $counter == 0}
           <tr class=rowsel id={$form.name}-{$dataPanel.ids[$counter]} normal=roweven select=rowsel
               onclick="CallFunction('{$form.name}.SelectRecord({$dataPanel.ids[$counter]},{$form.hasSubform})');">
         {elseif $counter is odd}
           <tr class=rowodd id={$form.name}-{$dataPanel.ids[$counter]} normal=rowodd select=rowsel
               onclick="CallFunction('{$form.name}.SelectRecord({$dataPanel.ids[$counter]},{$form.hasSubform})');">
         {else}
           <tr class=roweven id={$form.name}-{$dataPanel.ids[$counter]} normal=roweven select=rowsel
               onclick="CallFunction('{$form.name}.SelectRecord({$dataPanel.ids[$counter]},{$form.hasSubform})');">
         {/if}
         {foreach key=name item=cell from=$row}
            {if $cell != ''}
              <td valign=top class=cell>{$cell}</td>
            {else}
              <td valign=top class=cell>&nbsp;</td>
            {/if}
         {/foreach}
         {assign var=counter value=$counter+1}
     {/foreach}
     </tr>

   </table>
   
   <input type='hidden' id='{$form.name}_selectedId' name='_selectedId' value='{$dataPanel.ids[0]}'/>
   
   </div>
</td>
</tr>
</table>
</div>
</form>

<!-- add resizble behavior to table columns -->
<script>TableKit.Resizable.init($('{$form.name}_data').down('table'));</script>