<!DOCTYPE HTML>
<html>
<head>
	<?php 
    expTheme::head(array(
    	"xhtml"=>false,
    	"css_primer"=>array(
            YUI2_RELATIVE."yui2-reset-fonts-grids/yui2-reset-fonts-grids.css"),
    	"css_core"=>array("common"),
    	"css_links"=>true,
    	"css_theme"=>true
        )
    );
	?>
</head>
<body>
	<div id="doc2" class="threecol">
		<div id="hd">
			<a id="logo" href="<?php echo URL_FULL; ?>" title="<?php echo SITE_TITLE; ?>">
                <img alt="<?php echo SITE_HEADER; ?>" src="<?php echo THEME_RELATIVE; ?>images/logo.png">
			</a>
            <?php expTheme::module(array("controller"=>"navigation","action"=>"showall","view"=>"showall_YUI Top Nav")); ?>
			<?php expTheme::module(array("controller"=>"links","action"=>"showall","view"=>"showall_quicklinks","source"=>"@top")) ?>
			<?php expTheme::module(array("controller"=>"search","action"=>"show")) ?>
		</div>
		<div id="bd">
			<div id="leftcol">
    			<?php expTheme::module(array("module"=>"container","view"=>"Default","source"=>"@left")); ?>
			</div>
			<div id="centercol">
				<?php expTheme::main(); ?>
			</div>
            <div id="rightcol">
    			<?php expTheme::module(array("module"=>"container","view"=>"Default","source"=>"@right","scope"=>"sectional")); ?>
            </div>
		</div>
		<div id="ft">
            <?php expTheme::module(array("controller"=>"text","action"=>"showall","view"=>"single","source"=>"@footer")) ?>
            <div id="oicinfo"><a href="http://www.oicgroup.net" target="_blank">Website Design</a> and <a href="http://www.oicgroup.net" target="_blank">Website Development</a> by <a href="http://www.oicgroup.net" target="_blank"><strong>Online Innovative Creations</strong></a></div>
		</div>
	</div>
<?php expTheme::foot(); ?>
</body>
</html>
