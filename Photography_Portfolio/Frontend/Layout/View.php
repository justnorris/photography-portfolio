<?php


namespace Photography_Portfolio\Frontend\Layout;


use Photography_Portfolio\Frontend\Template;

class View {

	public static function load() {

		$template = self::find_view();
		/**
		 * Load Template if template is found
		 */
		if ( $template ) {
			load_template( $template, false );
		}
	}


	public static function find_view() {


		$portfolio = PP_Instance();


		/**
		 * Single Portfolio Entry
		 *
		 * @loads single-portfolio.php
		 */
		if ( $portfolio->query->is_single() ) {
			return Template::locate( 'single-portfolio.php' );
		}


		/**
		 * Taxonomies ( Portfolio Categories )
		 *
		 * @loads taxonomy-{term}.php
		 * @loads archive-portfolio.php
		 */
		if ( $portfolio->query->is_category() ) {

			$files = [ ];
			$term  = get_queried_object();

			if ( is_tax( 'pp_post_category' ) ) {
				$files[] = 'taxonomy-' . $term->taxonomy . '.php';
			}
			$files[] = 'archive-portfolio.php';

			return Template::locate( $files );


		}

		/**
		 * Archive
		 *
		 * @loads archive-portfolio.php
		 */
		if ( $portfolio->query->is_archive() ) {
			return Template::locate( 'archive-portfolio.php' );
		}

		var_dump( $portfolio->query );

	}
}