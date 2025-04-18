{* DO NOT EDIT THIS FILE! Use an override template instead. *}

<div class="context-block">
{* DESIGN: Header START *}<div class="box-header"><div class="box-tc"><div class="box-ml"><div class="box-mr"><div class="box-tl"><div class="box-tr">

<h1 class="context-title">{'Copy subtree Notification'|i18n( 'design/standard/content/copy_subtree_notification')}</h1>

{* DESIGN: Mainline *}<div class="header-mainline"></div>

{* DESIGN: Header END *}</div></div></div></div></div></div>

{* DESIGN: Content START *}<div class="box-ml"><div class="box-mr"><div class="box-content">
{foreach $notifications as $notification}
    <div class="block">
    {if $notification.Result|eq( true )}
            <h2>{'Successfully DONE.'|i18n( 'kernel/content/copysubtree' )}</h2>
    {else}
        <h2>{'Subtree was not copied.'|i18n( 'kernel/content/copysubtree' )}</h2>
        {if $notification.Errors|count|gt( 0 )}
            <h4>Errors:</h4>
            {foreach $notification.Errors as $item}
                {$item}<br />
            {/foreach}
        {/if}
    {/if}
    
    {if $notification.Notifications|count|gt( 0 )}
    <h4>Information:</h4>
    {foreach $notification.Notifications as $key => $item }
        {$item}<br />
    {/foreach}
    {/if}
    
    {if $notification.Warnings|count|gt( 0 )}
    <h4>Warnings:</h4>
    {foreach $notification.Warnings as $key => $item }
        {$item}<br />
    {/foreach}
    {/if}
    
    </div>
{/foreach}


{* DESIGN: Content END *}</div></div></div>

<form action={$redirect_url|ezurl} method="post">

<div class="controlbar">
{* DESIGN: Control bar START *}<div class="box-bc"><div class="box-ml"><div class="box-mr"><div class="box-tc"><div class="box-bl"><div class="box-br">
<div class="block">
    <input class="button" type="submit" value="{'OK'|i18n( 'design/standard/content/copy_subtree_notification' )}" />
</div>
{* DESIGN: Control bar END *}</div></div></div></div></div></div>
</div>

</form>
</div>
