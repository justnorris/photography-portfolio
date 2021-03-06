###
    Load Dependencies
###
Hooks = require( "wp_hooks" )
$ = require( "jQuery" )

# Expose some Photography Portfolio modules to the public for extensibility
window.PP_Modules =
	# Extend Portfolio Interface to build custom portfolio layouts based on PP Events
	Portfolio_Interface: require( "./portfolio/Portfolio_Interface" )

# Use `gallery_item_data` to get formatted item image sizes for lazy loading
	gallery:
		item_data   : require( "./gallery/gallery_item_data" )
		item_factory: require( "./gallery/gallery_item_factory" )

# Extend Abstract_Lazy_Loder to implement lazy loader for your layout
	Abstract_Lazy_Loader: require( "./lazy/Abstract_Lazy_Loader" )


window.Photography_Portfolio =
	Core            : require( "./core/start" )
	Portfolio_Layout: require( "./portfolio/start" )
	Gallery         : require( "./gallery/start" )
	Lazy_Loader     : require( "./lazy/start" )

###
	Boot on `document.ready`
###
$( document ).ready ->
	return if $( ".PP_Wrapper" ).length is 0 && not $( "body" ).hasClass( "PP_Portfolio" )

	# Boot
	Photography_Portfolio.Core.ready( )
	return
