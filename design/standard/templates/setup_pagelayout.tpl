{* DO NOT EDIT THIS FILE! Use an override template instead. *}
<!DOCTYPE html>
<html lang="{$site.http_equiv.Content-language|wash}">
<head>
    <!--[if lt IE 9]>
    <script type="text/javascript">
    // Make sure IE 6-8 is able to style html5 tags
    document.createElement('article');
    document.createElement('aside');
    document.createElement('footer');
    document.createElement('header');
    document.createElement('nav');
    document.createElement('section');
    document.createElement('meter');
    </script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href={"stylesheets/core.css"|ezdesign} />
    <link rel="stylesheet" type="text/css" href={"stylesheets/debug.css"|ezdesign} />
    <link rel="stylesheet" type="text/css" href={"stylesheets/setup.css"|ezdesign} />
    <link rel="stylesheet" type="text/css" href={"stylesheets/setup2.css"|ezdesign} />

    {include uri="design:page_head.tpl" enable_link=false()}

    <link rel="Shortcut icon" href={"favicon.ico"|ezimage} type="image/x-icon" />

</head>

<body>

<section id="page">

    <header>
    </header>


    <section id="content">
    <article>
          {* Debug errors and warnings are displayed here *}
          {include uri="design:page_warning.tpl"}

          {* Main stuff goes here *}
          {$module_result.content}
    </article>

    <aside class="helptext">
        <div class="setup_help">
          {* Setup help *}
          <h1 class="setup_help_summary">{"Help"|i18n("design/standard/setup")}</h1>
          {$module_result.help}
        </div>
        <div class="setup_summary">
          {* Setup summary *}
          <h1 class="setup_help_summary">{"Summary"|i18n("design/standard/setup")}</h1>
          {$module_result.summary}
        </div>
    </aside>
    </section>


    <aside class="progressbar">
        <p>{"&percent% completed"|i18n("design/standard/setup",,hash('&percent',$module_result.progress))}</p>
        <div><span style="width: {$module_result.progress|wash}%;"></span></div>
    </aside>

    <footer>
        <p><a href="https://ezpublishlegacy.se7enx.com">eZ Publish&trade;</a> copyright &copy; 1999-2024 <a href="https://se7enx.com">7x</a></p>
    </footer>

</section>

<!--DEBUG_REPORT-->

</body>
</html>
