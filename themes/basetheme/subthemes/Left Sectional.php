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
		<div id="doc4" class="yui-t2">
			<div id="hd">
				<h1 id="logo">
				    <a href="<?php echo URL_FULL; ?>" title="<?php echo SITE_TITLE; ?>"><?php echo ORGANIZATION_NAME; ?></a> <sub><?php echo SITE_HEADER; ?></sub>
				</h1>
                <?php expTheme::module(array("controller"=>"navigation","action"=>"showall","view"=>"showall_YUI Top Nav")); ?>
			</div>
			<div id="bd">
				<div class="yui-b">
	                <?php expTheme::module(array("module"=>"container","view"=>"Default","source"=>"@left","scope"=>"sectional")); ?>
				</div>
				<div id="yui-main">
					<div class="yui-b">
						<div class="yui-g">
	                        <?php expTheme::main(); ?>
						</div>
					</div>
				</div>
			</div>
			<div id="ft">
	            <?php expTheme::module(array("controller"=>"text","action"=>"showall","view"=>"single","source"=>"@footer","chrome"=>1)) ?>
			</div>
		</div>
	    <?php expTheme::foot(); ?>
	</body>
</html>
