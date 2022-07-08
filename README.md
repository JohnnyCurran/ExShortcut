# Shortcut CLI

## Usage
Obtain your Shortcut token from https://app.shortcut.com/settings/account/api-tokens
Set `SHORTCUT_TOKEN` as an env var:

```bash
export SHORTCUT_TOKEN=my_shortcut_token
```
(optional) If you know the project ID you want to work on, set `SHORTCUT_PROJECT_ID`
```bash
export SHORTCUT_PROJECT_ID=my_project_id
```

If you don't know your project ID, simply run:
```bash
shortcut projects
```

For a pretty-printed version (requires jq):

```bash
shortcut projects | jq '.[] | {name: .name, id: .id}'
```

```bash
shortcut  - commandline Shortcut API Integration
          - Operates on current story by default
          - Obtains current story ID from current git branch name
Usage:
new title [description]         Create new story with title and optional description
projects                        List all projects. Use with jq for pretty output, i.e. shorcut projects | jq '.[] | {name: .name, id: .id}'
whoami                          List info of the authenticated shortcut member from SHORTCUT_TOKEN
labels                          List labels and their attributes
label labelName                 Applies label 'labelName' to story from current branch
label storyId labelName         Applies label 'labelName' to story with id 'storyId'
```

## Examples

### Create Story
```bash
shortcut new 'my story' 'my description'
```

### View all labels
```bash
shortcut labels
```

### Set a label on a story
```bash
shortcut label 12345 bugfix
```

## Git integration

If you use suggested shortcut branches for git integration, Shortcut will automatically read the story ID from the current branch name
For example, to label your current story with `bugfix`, simply:

```bash
shortcut label bugfix
```
