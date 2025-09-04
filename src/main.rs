use std::process::Command;

fn main() {
    let output = Command::new("tmux")
        .args([
            "list-panes",
            "-F",
            "#{pane_id}x#{pane_left}x#{pane_width}x#{pane_top}x#{pane_height}",
        ])
        .output()
        .unwrap();

    let output = String::from_utf8_lossy(&output.stdout);
    let mut panes = Vec::new();
    output.lines().for_each(|line| {
        let res = line.split('x').to_owned().collect::<Vec<&str>>();

        panes.push(Pane {
            id: res[0].to_owned(),
            left: res[1].parse().unwrap(),
            width: res[2].parse().unwrap(),
            top: res[3].parse().unwrap(),
            height: res[4].parse().unwrap(),
            contents: None,
        });
    });

    for pane in panes.iter_mut() {
        let output = Command::new("tmux")
            .args(["capture-pane", "-t", &format!("{}", pane.id), "-p"])
            .output()
            .unwrap();

        pane.contents = Some(String::from_utf8_lossy(&output.stdout).to_string());

        dbg!(pane);
    }

    let output = Command::new("tmux")
        .args(["new-window", "-k", "-n", "vimlink"])
        .output()
        .unwrap();

    let output = Command::new("tmux")
        .args(["split-window", "-h", "-p", "30"])
        .output()
        .unwrap();

}

#[derive(Debug)]
pub struct Pane {
    pub id: String,
    pub left: u32,
    pub top: u32,
    pub width: u32,
    pub height: u32,
    pub contents: Option<String>,
}
