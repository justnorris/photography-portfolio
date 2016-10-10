###
    Dependencies
###
$ = require( 'jQuery' )
Hooks = require( "wp_hooks" )

class Masonry

	Elements:
		container: 'PP_Masonry'
		sizer    : 'PP_Masonry__sizer'
		item     : 'PP_Masonry__item'




	constructor: ( $parent = $( document ) )->
		@$container = $parent.find( ".#{@Elements.container}" )

		@create()


	create: =>
		return if @$container.length is 0

		@$container.addClass( 'is-preparing-masonry' )

		@maybe_create_sizer()
		Hooks.doAction 'pp.masonry.start/before'

		# Only initialize, if no masonry exists
		@$container.masonry
			itemSelector: ".#{@Elements.item}"
			columnWidth : ".#{@Elements.sizer}"
			gutter      : 0
			initLayout  : false


		@$container.masonry 'on', 'layoutComplete', =>
			@$container.removeClass( 'is-preparing-masonry' )
			Hooks.doAction 'pp.masonry.start/complete'


		@$container.masonry()
		Hooks.doAction 'pp.masonry.start/layout'


		return


	destroy: =>
		@maybe_remove_sizer()

		if @$container.length > 0
			@$container.masonry( 'destroy' )


		return

	refresh: =>
		@$container.maosnry( 'layout' )

	###

		Create a sizer element for jquery-masonry to use

	###
	maybe_create_sizer: ->
		@create_sizer() if @sizer_doesnt_exist()
		return

	maybe_remove_sizer: ->
		return if @$container.length isnt 1
		@$container.find( ".#{@Elements.sizer}" ).remove()
		return

	sizer_doesnt_exist: -> @$container.find( ".#{@Elements.sizer}" ).length is 0


	create_sizer: ->
		@$container.append """<div class="#{@Elements.sizer}"></div>"""

		return


module.exports = Masonry