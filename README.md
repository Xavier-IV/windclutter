![Test Badge](https://github.com/Xavier-iV/tail_draft/actions/workflows/main.yml/badge.svg)

## Tail Draft

Spam this buddy with your bulky TailwindCSS class, and sort it out later.

## Goal

Helping you stay focused and develop faster with your project.

## Concept

### 1 - Basic Cleanup
```bash
# standard button
$ tail_draft draft border rounded-md px-4 py-2

$ tail_draft --organize
[1/1] What do you want to do with this class?
'border rounded-md px-4 py-2'
name: .btn

Done!
Exported to compiled.css
```

Generated Output

```css
/* compiled.css */
.btn {
    @apply border rounded-md px-4 py-2;
}
```

### 2 - Guided cleanup

```bash
$ tail_draft guided

[1/1] Cleanup progress
1. Global find this in your project:
class="border rounded-md px-4 py-2"

2. Replace with:
class="btn"

Done!
```

## Contributing

Take a look into:
https://github.com/Xavier-IV/tail_draft/wiki/Developer