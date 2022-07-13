// by orzun
// License: GPLv3
// Install:
// mkdir -p ~/.local/share/gnome-shell/extensions/move-resize@orzun
// cp ./extension.js ./metadata.json ~/.local/share/gnome-shell/extensions/move-resize@orzun
// Usage:
// gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/MoveResize --method org.gnome.Shell.Extensions.MoveResize.Call "'firefox'" 1 0 0 400 800
// https://gist.github.com/tuberry/dc651e69d9b7044359d25f1493ee0b39

const { Gio } = imports.gi;

const MR_DBUS_IFACE = `
<node>
    <interface name="org.gnome.Shell.Extensions.MoveResize">
        <method name="Call">
            <arg type="s" direction="in" name="wmclass"/>
            <arg type="u" direction="in" name="workspace"/>
            <arg type="u" direction="in" name="x"/>
            <arg type="u" direction="in" name="y"/>
            <arg type="u" direction="in" name="width"/>
            <arg type="u" direction="in" name="height"/>
        </method>
    </interface>
</node>`;

class Extension {
    enable() {
        this._dbus = Gio.DBusExportedObject.wrapJSObject(MR_DBUS_IFACE, this);
        this._dbus.export(Gio.DBus.session, '/org/gnome/Shell/Extensions/MoveResize');
    }

    disable() {
        this._dbus.flush();
        this._dbus.unexport();
        delete this._dbus;
    }

    Call(wmclass, workspace, x, y, width, height) {
        let win = global.get_window_actors()
            .map(a => a.meta_window)
            .map(w => ({ class: w.get_wm_class(), title: w.get_title(), ws: w }))
            .find(ws => ws.title == wmclass);
        if (win) {
            win.ws.change_workspace_by_index(workspace, false);
            win.ws.move_resize_frame(0, x, y, width, height);
			win.ws.make_above();
        } else {
            throw new Error('Not found');
        }
    }
}

function init() {
    return new Extension();
}
