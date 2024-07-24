<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'dongkseo' );

/** Database password */
define( 'DB_PASSWORD', '6071' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          'w)PMkGg8P2-y)nnGi3pe:(yGN:tW?Z4>R/Ad+UbSL%:uEs:$Fi1|sll,k<a$DQcl' );
define( 'SECURE_AUTH_KEY',   '%&}|]Aljmba1Y@{.qC^q7#G&^`?s30B*`z+Zx7$loJv_4c}/,az$G_jL8sl*X2 =' );
define( 'LOGGED_IN_KEY',     'bVHXx.>Yq7s./t#bAd{?@a &U-qev_ZGrRh?z!nm,KJw)A*GN[MuklMSTlEmoM_^' );
define( 'NONCE_KEY',         'oi@>e1)T.vH:+M~<~}N2>nRR+4d}YIv][BV}4]*I%^a-wVP_I.lznu7Wcc^]b/1B' );
define( 'AUTH_SALT',         ']z1 Ew K$V$v|sslvrMeg<@,).!w |Lhx{l!;F:uQHo(:!1+~ss$#$BH(|/{/W_[' );
define( 'SECURE_AUTH_SALT',  'bC?l6^N8]pJO8ZJ1vB0#kwn4U95%~p!+8lef%B2<ht!Mk2I,>*YK?wyc{21zz!BG' );
define( 'LOGGED_IN_SALT',    'K10f?w*-K2e(Nk<&z.&r5$hE>a#_xvH4f3G ev@$G%OtZi.U@{Lbljs:{QitSPJ6' );
define( 'NONCE_SALT',        'OW-=J&{22{e)WlO;q8@%%3w[h/jB%DbJG}wMXitd5&f2?%{4$[c`,i:wbzy`JpDW' );
define( 'WP_CACHE_KEY_SALT', '.b^3Y[s(!W@!=.c&w^>hxm89Yi|K,x8 `U4WS %zo`>n<[6>3=;qm)-Kh,Gk9hv0' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
