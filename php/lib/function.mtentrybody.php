<?php
function smarty_function_mtentrybody($args, &$ctx) {
    $entry = $ctx->stash('entry');
    $text = $entry['entry_text'];

    $cb = $entry['entry_convert_breaks'];
    if (isset($args['convert_breaks'])) {
        $cb = $args['convert_breaks'];
    } elseif (!isset($cb)) {
        $blog = $ctx->stash('blog');
        $cb = $blog['blog_convert_paras'];
    }
    if ($cb) {
        if (($cb == '1') || ($cb == '__default__')) {
            # alter EntryBody, EntryMore in the event that
            # we're doing convert breaks
            $cb = 'convert_breaks';
        }
        if ($cb) {
            # invoke modifier to format
            if ($ctx->load_modifier($cb)) {
                $mod = 'smarty_modifier_'.$cb;
                $text = $mod($text);
            }
        }
    }
    if (isset($args['words'])) {
        require_once("MTUtil.php");
        return first_n_text($text, $args['words']);
    } else {
        return $text;
    }
}
?>
