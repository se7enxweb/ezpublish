{* DO NOT EDIT THIS FILE! Use an override template instead. *}

{if is_unset( $load_css_file_list )}
    {def $load_css_file_list = true()}
{/if}

<style type="text/css">
    @import url({'stylesheets/core.css'|ezdesign});
    @import url({'stylesheets/site.css'|ezdesign});
    @import url({'stylesheets/debug.css'|ezdesign});

{if $load_css_file_list}
    {foreach ezini( 'StylesheetSettings', 'CSSFileList', 'design.ini' ) as $css_file}
        @import url({concat( 'stylesheets/',$css_file )|ezdesign});
    {/foreach}
{/if}
</style>

{include uri='design:page_head_style_inline.tpl'}