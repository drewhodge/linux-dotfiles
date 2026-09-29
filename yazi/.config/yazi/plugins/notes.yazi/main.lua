local M = {}

local hovered = ya.sync(function()
    local h = cx.active.current.hovered
    if not h then
        return nil
    end

    return {
        name = h.name,
        parent = tostring(h.url.parent),
    }
end)

local function read_note(file)
	local parent = file.url.parent
	if not parent then
		return nil
	end

	local notes_file = tostring(parent) .. "/.yazi-notes.toml"
	local f = io.open(notes_file, "r")
	if not f then
		return nil
	end

	local content = f:read("*a")
	f:close()

	-- Escape Lua pattern characters in the filename.
	local name = file.name:gsub("([^%w])", "%%%1")

	-- Find the table belonging to the selected file.
	local section = content:match(
		'%["' .. name .. '"%](.-)\n%['
	) or content:match(
		'%["' .. name .. '"%](.*)$'
	)

	if not section then
		return nil
	end

	-- Initially we understand just:
	-- note = "..."
	return section:match('note%s*=%s*"(.-)"')
end

function M:spot(job)
	local rows = require("file"):spot_base(job)
	local note = read_note(job.file)

	if note then
		rows[#rows + 1] = ui.Row {}
		rows[#rows + 1] =
			ui.Row({ "Note" }):style(ui.Style():fg("green"))
		rows[#rows + 1] = ui.Row { "  Note:", note }
	end

	ya.spot_table(
		job,
		ui.Table(rows)
			:area(ui.Pos { "center", w = 70, h = 24 })
			:row(1)
			:col(1)
			:col_style(th.spot.tbl_col)
			:cell_style(th.spot.tbl_cell)
			:widths {
				ui.Constraint.Length(14),
				ui.Constraint.Fill(1),
			}
	)
end

function M:entry(job)
    if job.args[1] ~= "edit" then
        return
    end

    local file = hovered()
    if not file then
        return
    end

    local notes_file = file.parent .. "/.yazi-notes.toml"
    local name = file.name

	local f = io.open(notes_file, "r")
	local content = ""

	if f then
		content = f:read("*a")
		f:close()
	end

	-- Find an existing note for this file.
	local escaped = name:gsub("([^%w])", "%%%1")
	local section = content:match(
		'%["' .. escaped .. '"%](.-)\n%['
	) or content:match(
		'%["' .. escaped .. '"%](.*)$'
	)

	local old_note = ""
	if section then
		old_note = section:match('note%s*=%s*"(.-)"') or ""
	end

	local note, event = ya.input {
		title = "Note for " .. name .. ":",
		value = old_note,
		pos = { "top-center", y = 3, w = 70 },
	}

	if event ~= 1 then
		return
	end

	-- Escape characters that matter inside a TOML quoted string.
	note = note:gsub("\\", "\\\\")
	note = note:gsub('"', '\\"')

	local heading = '["' .. name .. '"]'
	local replacement = heading .. '\nnote = "' .. note .. '"'

	if section then
		-- Replace just the note value in the existing section.
		local new_section = section:gsub(
			'note%s*=%s*".-"',
			'note = "' .. note .. '"',
			1
		)

		if new_section == section then
			new_section = section .. '\nnote = "' .. note .. '"'
		end

		local start_pos, end_pos = content:find(
			'%["' .. escaped .. '"%]'
		)

		local next_pos = content:find("\n%[", end_pos + 1)

		if next_pos then
			content =
				content:sub(1, start_pos - 1)
				.. heading
				.. new_section
				.. content:sub(next_pos)
		else
			content =
				content:sub(1, start_pos - 1)
				.. heading
				.. new_section
		end
	else
		if content ~= "" and not content:match("\n$") then
			content = content .. "\n"
		end

		if content ~= "" then
			content = content .. "\n"
		end

		content = content .. replacement .. "\n"
	end

	local out = io.open(notes_file, "w")
	if not out then
		ya.notify {
			title = "Yazi Notes",
			content = "Could not write " .. notes_file,
			timeout = 5,
			level = "error",
		}
		return
	end

	out:write(content)
	out:close()

	ya.notify {
		title = "Yazi Notes",
		content = "Note saved",
		timeout = 2,
	}
end

return M
