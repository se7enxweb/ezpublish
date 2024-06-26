{* DO NOT EDIT THIS FILE! *}

<div class="context-block">
{* DESIGN: Header START *}<div class="box-header"><div class="box-ml">
<h1 class="context-title">{'eZ Publish information: %version'|i18n( 'design/admin/ezinfo/about',, hash( '%version', $ezinfo ) )|wash}</h1>
{* DESIGN: Mainline *}<div class="header-mainline"></div>
{* DESIGN: Header END *}</div></div>
{* DESIGN: Content START *}<div class="box-bc"><div class="box-ml"><div class="box-content">

<div class="context-attributes">

<h2>eZ Publish</h2>

<h3>{'What is eZ Publish?'|i18n( 'design/admin/ezinfo/about' )}</h3>
{if is_set( $what_is_ez_publish )}
    {$what_is_ez_publish}
{/if}

<h3>{'License'|i18n( 'design/admin/ezinfo/about' )}</h3>
{if $license}
    <pre style="height: 300px; overflow:scroll;">{$license|wash}</pre>
{else}
    <p>{'Could not load LICENSE file! You should have a LICENSE file in your eZ Publish root directory.'|i18n( 'design/admin/ezinfo/about' )}</p>
{/if}

{if and( is_set( $contributors ), is_array( $contributors ), count( $contributors )|ge( 1 ) )}
    <h3>{'Contributors'|i18n( 'design/admin/ezinfo/about' )}</h3>
    <p>
        The following is a list of <a href="https://ezpublishlegacy.se7enx.com">eZ Publish</a> contributors who have licensed their work for use by <a href="https://se7enx.com/">7x</a> under the terms and conditions of
        the eZ Systems Contributor Licensing Agreement. As permitted by this agreement with the contributors, <a href="https://se7enx.com/">7x</a> is redistributing the
        contribution under the same license as the file that the contribution is included in. The list of contributors includes the
        contributors&apos;s name, optional contact info and a list of files that they have either contributed or contributed work to.
    </p>
    <ul>
        {foreach $contributors as $contributor}
             <li>{$contributor['name']|wash} : {$contributor['files']|wash}</li>
        {/foreach}
    </ul>
{/if}

<h3>{'Copyright Notice'|i18n( 'design/admin/ezinfo/about' )}</h3>
<p>
    Copyright for eZ Publish is included in the License shown above. Portions are copyright by other parties. A complete list of all contributors and third-party
    software follows.
</p>

{if and( is_set( $third_party_software ), is_array( $third_party_software ), count( $third_party_software )|ge( 1 ) )}
    <h2>{'Third-Party Software'|i18n( 'design/admin/ezinfo/about' )}</h2>
    <p>
        The following is a list of the third-party software that is distributed with this copy of <a href="https://ezpublishlegacy.se7enx.com">eZ Publish</a>. The list of third party
        software includes the license for the software in question and the directory or files that contain the third-party software.
    </p>

    <ul>
        {foreach $third_party_software as $software_key => $software}
          <li>{$software}</li>
        {/foreach}
    </ul>
{/if}

<h2>{'Extensions'|i18n( 'design/admin/ezinfo/about' )}</h2>
<p>The following is a list of the extensions that have been loaded at run-time by this copy of <a href="https://ezpublishlegacy.se7enx.com">eZ Publish</a>.</p>
{if is_set( $extensions )}
    {foreach $extensions as $ext_name => $extension}
        {if is_array( $extension )}
            <ul>
                <li>
                    {foreach $extension as $ext_key => $ext_info}
                        {$ext_key|wash}:
                        {if not( is_array( $ext_info ) )}
                            {$ext_info}<br />
                        {else}
                            <ul>
                                <li>
                                    {foreach $ext_info as $ext_info_key => $ext_info_value}
                                        {$ext_info_key|wash} : {$ext_info_value|wash}<br />
                                    {/foreach}
                                </li>
                            </ul>
                        {/if}
                    {/foreach}
                </li>
            </ul>
        {/if}
    {/foreach}
{/if}

</div>
{* DESIGN: Content END *}</div></div></div>
</div>
