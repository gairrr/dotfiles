""" helper methods used in ultisnips snippets. """

import string, vim, re

def is_visual_mode(snip):
    return snip.visual_mode == "v"

def is_visual_line_mode(snip):
    return snip.visual_mode == "V"

def is_visual_block_mode(snip):
    return snip.visual_mode == ""

def update():
    vim.eval('feedkeys(":up\<cr>")')

def escape():
    vim.eval('feedkeys("\<esc>")')

def escape_hat_pos():
    vim.eval('feedkeys("\<esc>^")')

def remove_right_side_of_the_cursor(snip):
    snip.buffer[snip.line] = snip.buffer[snip.line][:snip.cursor[1]]
    snip.cursor.set(snip.line, -1)

def _parse_comments(s):
    """ parse vim's comments option to extract comment format """
    i = iter(s.split(","))

    rv = []
    try:
        while True:
            # get the flags and text of a comment part
            flags, text = next(i).split(':', 1)

            if len(flags) == 0:
                rv.append(('OTHER', text, text, text, ""))
            # parse 3-part comment, but ignore those with 0 flag
            elif 's' in flags and '0' not in flags:
                ctriple = ["TRIPLE"]
                indent = ""

                if flags[-1] in string.digits:
                    indent = " " * int(flags[-1])
                ctriple.append(text)

                flags, text = next(i).split(':', 1)
                assert flags[0] == 'm'
                ctriple.append(text)

                flags, text = next(i).split(':', 1)
                assert flags[0] == 'e'
                ctriple.append(text)
                ctriple.append(indent)

                rv.append(ctriple)
            elif 'b' in flags:
                if len(text) == 1:
                    rv.insert(0, ("SINGLE_CHAR", text, text, text, ""))
    except StopIteration:
        return rv

def get_comment_format():
    """ returns a 4-element tuple (first_line, middle_lines, end_line, indent)
    representing the comment format for the current file.

    it first looks at the 'commentstring', if that ends with %s, it uses that.
    otherwise it parses '&comments' and prefers single character comment
    markers if there are any."""

    commentstring = vim.eval("&commentstring")
    if commentstring.endswith("%s"):
        c = commentstring[:-2]
        return (c.rstrip(), c.rstrip(), c.rstrip(), "")
    comments = _parse_comments(vim.eval("&comments"))
    for c in comments:
        if c[0] == "SINGLE_CHAR":
            return c[1:]
    return comments[0][1:]

def is_simple_comment_format():
    return get_comment_format()[0] == get_comment_format()[2]
