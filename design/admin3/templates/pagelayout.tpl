<!DOCTYPE html>
<html lang="{$site.http_equiv.Content-language|wash}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
{* Do some uncacheable left + right menu stuff before cache-block's *}
{def $ui_context_edit      = eq( $ui_context, 'edit' )
     $content_edit         = and( $ui_context_edit, eq( $ui_component, 'content' ) )
     $hide_left_menu       = first_set( $module_result.content_info.persistent_variable.left_menu, $content_edit|not )|not
     $hide_right_menu      = first_set( $module_result.content_info.persistent_variable.extra_menu, $ui_context_edit|not )|not
     $edit_menu_collapsed = cond( ezpreference( 'admin_edit_menu_collapsed' ), 1, 0 )
     $collapse_left_menu  = cond( ezpreference( 'admin_left_menu_show' ), 1, 1 )
     $collapse_right_menu  = ezpreference( 'admin_right_menu_show' )|not
     $admin_left_size      = ezpreference( 'admin_left_menu_size' )
     $admin_theme          = ezpreference( 'admin_theme' )
     $left_size_hash       = 0
     $search_hash          = array( cond( ezhttp_hasvariable( 'SectionID', 'get' ), ezhttp( 'SectionID', 'get' ) ) )
     $user_hash = concat( $current_user.role_id_list|implode( ',' ), ',', $current_user.limited_assignment_value_list|implode( ',' ) )
}

{if $hide_left_menu}
{set $collapse_left_menu = true()}
{/if}

{if $hide_right_menu}
{set $collapse_right_menu = false()}
{/if}

{if and( $ui_context_edit|not, or( $collapse_right_menu, $admin_left_size, $hide_left_menu ))}
<style type="text/css">
{if $collapse_right_menu}
    div#page div#rightmenu  {ldelim} width: 18px; {rdelim}
    div#page div#maincolumn {ldelim} margin-right: 0px; {rdelim}
{else}
    div#page a.show-hide-control-right {ldelim} left: 8px; {rdelim}
{/if}
{if $collapse_left_menu}
    div#page div#leftmenu  {ldelim} display: none; {rdelim}
    div#page div#maincolumn {ldelim} margin-left: 11px; {rdelim}
{else}
    div#page div#leftmenu  {ldelim} display: contents; {rdelim}
    div#page div#maincolumn {ldelim} margin-left: 10px; {rdelim}
{/if}
{if $hide_left_menu}
div#maincolumn {ldelim} padding-right: 12px; padding-left: 50px; {rdelim}
{else}
    {if $admin_left_size}
        {def $left_menu_widths = ezini( 'LeftMenuSettings', 'MenuWidth', 'menu.ini')}
        {if is_set( $left_menu_widths[$admin_left_size] )}
            {set $left_size_hash = $left_menu_widths[$admin_left_size]}
            div#leftmenu   {ldelim} width: {$left_size_hash|int}em; {rdelim}
            div#maincontent {ldelim} margin-left: 0px; {rdelim}
        {else}
            div#page div#maincontent {ldelim} margin-left: -30px; {rdelim}
        {/if}
        {undef $left_menu_widths}
    {/if}
{/if}
</style>
{/if}

{* Pr uri header cache
 Need navigation part for cases like content/browse where node id is taken from caller params *}
{cache-block keys=array( $module_result.uri, $user_hash, $admin_theme, $access_type, first_set( $module_result.navigation_part, $navigation_part.identifier ), $search_hash ) ignore_content_expiry}

{include uri='design:page_head.tpl'}

{include uri='design:page_head_style.tpl'}
{include uri='design:page_head_script.tpl'}

</head>
<body>

<div id="page" class="{$navigation_part.identifier} section_id_{first_set( $module_result.section_id, 0 )}">

<div id="header">
    <div id="header-design" class="float-break">
        {* HEADER ( SEARCH, LOGO AND USERMENU ) *}
        {* include uri='design:page_header.tpl' *}

        {* Pr tab header cache *}
        {cache-block keys=array( $ui_context, $ui_component, $user_hash, $access_type, first_set( $module_result.navigation_part, $navigation_part.identifier ) ) ignore_content_expiry}

        {* TOP MENU / TABS *}
        {include uri='design:page_topmenu.tpl'}
    </div>
</div>
{/cache-block}{* /Pr tab cache *}

<hr class="hide" />
{/cache-block}{* /Pr uri cache *}

<div id="columns"{if $hide_right_menu} class="hide-rightmenu"{/if}>
<script type="text/javascript">
{literal}

YUI(YUI3_config).use('ezcollapsiblemenu', 'event', 'io-ez', function (Y) {

    Y.on('domready', function () {
        var leftmenu = new Y.eZ.CollapsibleMenu({
            link: '#objectinfo-showhide',
            content: false,
{/literal}
            collapsed: "{$collapse_left_menu}",
{literal}
            elements:[{
                selector: '#leftmenu',
                duration: 0.4,
                fullStyle: {marginLeft: '0', display: 'contents'},
                collapsedStyle: {}
            },{
                selector: '#leftmenu-design',
                duration: 0.4,
                fullStyle: {display: 'contents'},
                collapsedStyle: {display: 'none'}
            },{
                selector: '#left-panels-separator',
                duration: 0.4,
                fullStyle: {display: 'block'},
                collapsedStyle: {display: 'block'}
            },{
                selector: '.show-hide-control',
                duration: 0.4,
                fullStyle: {backgroundPositionX: '-20px', backgroundPositionY: '-461px', backgroundRepeat: 'no-repeat', right: '10px'},
                collapsedStyle: {backgroundPositionX: '-20px', backgroundPositionY: '-461px', backgroundRepeat: 'no-repeat', marginTop: '-47%', right: '10px'}
            },{
                selector: '#maincontent',
                duration: 0.4,
                // workaround to http://yuilibrary.com/projects/yui3/ticket/2531641
                // for IE, margin has to be set in px
                fullStyle: {marginLeft: '-30px'},
                collapsedStyle: {marginLeft: '-30px'}
            }],
            callback: function () {
                var p = 1;
                if ( this.conf.collapsed )
                    p = 0;
                Y.io.ez.setPreference('admin_left_menu_show', p);
                Y.io.ez.setPreference('admin_edit_menu_collapsed', this.conf.collapsed);
            }

            });
        });
});
{/literal}
</script>

{if $hide_left_menu}
{else}
<div id="left-panels-separator">
    <div class="panels-separator-top"></div>
    <div id="widthcontrol-handler" class="">
      {if or( $hide_left_menu, $collapse_left_menu )}
      <a id="objectinfo-showhide" class="show-hide-control" title="Show / Hide leftmenu" href={'/user/preferences/set/admin_left_menu_show/1'|ezurl}></a>
      {else}
      <a id="objectinfo-showhide" class="show-hide-control" title="Show / Hide leftmenu" href={'/user/preferences/set/admin_left_menu_show/0'|ezurl}></a>
      {/if}
        {* <div class="widthcontrol-grippy"></div> *}
    </div>
    <div class="panels-separator-bottom"></div>
</div>
{/if}

<div id="right-panels-separator">
    <div class="panels-separator-top"></div>
    <div class="panels-separator-bottom"></div>
</div>

<div id="canvas-top"></div>
{* RIGHT MENU *}
<div id="rightmenu">
{if or( $hide_right_menu, $collapse_right_menu )}
    <a id="rightmenu-showhide" class="show-hide-control-right" title="{'Show / Hide rightmenu'|i18n( 'design/admin/pagelayout/rightmenu' )}" href={'/user/preferences/set/admin_right_menu_show/1'|ezurl}></a>
    <div id="rightmenu-design"></div>
{else}
    <a id="rightmenu-showhide" class="show-hide-control-right" title="{'Hide / Show rightmenu'|i18n( 'design/admin/pagelayout/rightmenu' )}" href={'/user/preferences/set/admin_right_menu_show/0'|ezurl}></a>
    <div id="rightmenu-design">
        {tool_bar name='admin_right' view='full'}
        {tool_bar name='admin_developer' view='full'}
    </div>
    <script type="text/javascript">
    {literal}

    YUI(YUI3_config).use('ezcollapsiblemenu', 'event', 'io-ez', 'node', function (Y) {

        Y.on('domready', function () {
            var rightmenu = new Y.eZ.CollapsibleMenu({
                link: '#rightmenu-showhide',
                content: ['', ''],
                collapsed: 0,
                elements:[{
                    selector: '#rightmenu',
                    duration: 0.4,
                    fullStyle: {width: '234px'},
                    collapsedStyle: {width: '18px'}
                },{
                    selector: '#maincolumn',
                    duration: 0.4,
                    fullStyle: {marginRight: '210px'},
                    collapsedStyle: {marginRight: '0px'}
                },{
                    selector: '#right-panels-separator',
                    duration: 0.4,
                    fullStyle: {right:'181px'},
                    collapsedStyle: {right: '-42px'}
                },{
                    selector: '#rightmenu-showhide',
                    duration: 0.4,
                    fullStyle: {left: '8px'},
                    collapsedStyle: {left: '8px'}
                }],
                callback: function () {
                    var p = 1;
                    if ( this.conf.collapsed )
                        p = 0;
                    Y.io.ez.setPreference('admin_right_menu_show', p);
                }
            });
        });
    });

    {/literal}
    </script>
{/if}
</div>


<div id="maincolumn">

{* Pr uri Path/Left menu cache (dosn't use ignore_content_expiry because of content structure menu  ) *}
{cache-block keys=array( $module_result.uri, $user_hash, $left_size_hash, $access_type, first_set( $module_result.navigation_part, $navigation_part.identifier ) )}

<hr class="hide" />

{* LEFT MENU / CONTENT STRUCTURE MENU *}
{if $hide_left_menu}
{else}
    {include uri='design:page_leftmenu.tpl'}
{/if}

{/cache-block}{* /Pr uri cache *}

{* Main area START *}
{if $hide_left_menu}
    {include uri='design:page_mainarea.tpl'}
{else}
    <div id="maincontent"{if $edit_menu_collapsed} style="margin-left: -34px; margin-right:-8px"{/if}>
    <div id="maincontent-design" class="float-break"><div id="fix">

    <div id="path">
        <div id="path-design">
            {include uri='design:page_toppath.tpl'}
        </div>
    </div>

    <!-- Maincontent START -->
    {include uri='design:page_mainarea.tpl'}
    <!-- Maincontent END -->
    </div>
    <div class="break"></div>
    </div></div>
{/if}
{* Main area END *}
</div>


<div class="break"></div>
<div id="canvas-bottom"></div>
</div><!-- div id="columns" -->

<hr class="hide" />


{cache-block keys=array( $access_type ) ignore_content_expiry}
<div id="footer" class="float-break">
<div id="footer-design">
    {include uri='design:page_copyright.tpl'}
</div>
</div>

<div class="break"></div>

{* The popup menu include must be outside all divs. It is hidden by default. *}
{include uri='design:popupmenu/popup_menu.tpl'}

{/cache-block}

<script type="text/javascript">
document.getElementById('header-usermenu-logout').innerHTML += '<span class="header-usermenu-name">{$current_user.login|wash}<\/span>';

document.getElementById('right-panels-separator').style.right = (parseInt(document.getElementById('rightmenu').offsetWidth,10) - 60) + 'px';

{literal}
(function( $ )
{
    var searchtext = document.getElementById('searchtext');
    if ( !searchtext || searchtext.disabled )
        return;

    jQuery( searchtext ).val( searchtext.title
    ).addClass('passive'
    ).focus(function(){
        if ( this.value === this.title )
        {
            jQuery( this ).removeClass('passive').val('');
        }
    }).blur(function(){
        if ( this.value === '' )
        {
            jQuery( this ).addClass('passive').val( this.title );
        }
    });
})( jQuery );
{/literal}
</script>


</div><!-- div id="page" -->

{* This comment will be replaced with actual debug report (if debug is on). *}
<!--DEBUG_REPORT-->

{* modal window and AJAX stuff *}
<div id="overlay-mask" style="display:none;"></div>
<img src={'2/loader.gif'|ezimage()} id="ajaxuploader-loader" style="display:none;" alt="{'Loading...'|i18n( 'design/admin/pagelayout' )}" />


</body>
</html>
