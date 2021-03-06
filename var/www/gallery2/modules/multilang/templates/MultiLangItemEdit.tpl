{*
 * $Revision: 1.4 $
 * If you want to customize this file, do not edit it directly since future upgrades
 * may overwrite it.  Instead, copy it into a new directory called "local" and edit that
 * version.  Gallery will look for that file first and use it if it exists.
 *}
<script type="text/javascript">{literal}
// <![CDATA[
var index = 0, isChanged = 0;
function pick(idx) {
  if (isChanged && !confirm('Switch language without saving changes?')) {
    var s = document.getElementById('language');
    s.selectedIndex = index;
    return;
  }
  var o = document.getElementById('title');
  o.value = document.getElementById('ttl_' + idx).innerHTML;
  o = document.getElementById('summary');
  o.value = document.getElementById('sum_' + idx).innerHTML;
  o = document.getElementById('description');
  o.value = document.getElementById('dsc_' + idx).innerHTML;
  index = idx;
  isChanged = 0;
}
function changed() { isChanged = 1; }
// ]]>
{/literal}</script>
<div style="display:none;visibility:hidden">
{counter start=-1 assign=idx}
{foreach from=$form.languageList key=language item=label}{counter assign=idx}
{if isset($form.languageData[$language])}
<div id="ttl_{$idx}">{$form.languageData[$language].title}</div>
<div id="sum_{$idx}">{$form.languageData[$language].summary}</div>
<div id="dsc_{$idx}">{$form.languageData[$language].description}</div>
{else}
<div id="ttl_{$idx}"></div><div id="sum_{$idx}"></div><div id="dsc_{$idx}"></div>
{/if}
{/foreach}
</div>

<div class="gbBlock">
  <p class="giDescription">
    {g->text text="Enter text for additional languages.  If all fields are blank then the primary data shown below will be used.  If any fields are non-empty then the multilanguage data will be used, even if some fields are blank."}
  </p>

  <h4> {g->text text="Item Data"} </h4>

  <table class="gbDataTable"><tr>
    <td> {g->text text="Title"} </td>
    <td> {$form.mainTitle|markup} </td>
  </tr><tr>
    <td> {g->text text="Summary"} </td>
    <td> {$form.mainSummary|markup} </td>
  </tr><tr>
    <td> {g->text text="Description"} </td>
    <td> {$form.mainDescription|markup} </td>
  </tr></table>

  <h4> {g->text text="Language"} </h4>

  <select id="language" onchange="pick(this.selectedIndex)"
   name="{g->formVar var="form[language]"}">
    {html_options options=$form.languageList selected=$form.selectedLanguage}
  </select>

  <h4> {g->text text="Title"} </h4>
  <p class="giDescription">
    {g->text text="The title of this item."}
  </p>

  {include file="gallery:modules/core/templates/MarkupBar.tpl"
	   viewL10domain="modules_core" element="title" firstMarkupBar="true"}
  <input type="text" id="title" size="40" onchange="changed()"
   name="{g->formVar var="form[title]"}" value=""/>

  {if !empty($form.error.title.missingRootTitle)}
  <div class="giError">
    {g->text text="The root album must have a title."}
  </div>
  {/if}

  <h4> {g->text text="Summary"} </h4>
  <p class="giDescription">
    {g->text text="The summary of this item."}
  </p>

  {include file="gallery:modules/core/templates/MarkupBar.tpl"
	   viewL10domain="modules_core" element="summary"}
  <input type="text" id="summary" size="40" onchange="changed()"
   name="{g->formVar var="form[summary]"}" value=""/>

  <h4> {g->text text="Description"} </h4>
  <p class="giDescription">
    {g->text text="This is the long description of the item."}
  </p>
  {include file="gallery:modules/core/templates/MarkupBar.tpl"
	   viewL10domain="modules_core" element="description"}
  <textarea id="description" rows="4" cols="60" onchange="changed()"
   name="{g->formVar var="form[description]"}"></textarea>
</div>

<div class="gbBlock gcBackground1">
  <input type="submit" class="inputTypeSubmit"
   name="{g->formVar var="form[action][save]"}" value="{g->text text="Save"}"/>
  <input type="submit" class="inputTypeSubmit"
   name="{g->formVar var="form[action][reset]"}" value="{g->text text="Reset"}"/>
</div>

<script type="text/javascript">
// <![CDATA[
pick({$form.selectedIndex});
// ]]>
</script>
