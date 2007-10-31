<?php
function smarty_function_mttagcount($args, &$ctx) {
    $tag = $ctx->stash('Tag');
    if (!$tag) return '';
    if (is_array($tag)) {
        return $tag['tag_count'];
    } else {
        return 0;
    }
}
?>
