![Test Badge](https://github.com/Xavier-iV/tail_draft/actions/workflows/main.yml/badge.svg)

## Tail Draft

You created awesome project, it's completed, your users are happy. But now you are left with this question:

> What am I going to do with this TailwindCSS class clutter?

You know what I'm talking about.

This tool aim to:

- Provide analysis of your project
- Identify common uses of Tailwind class
- Cleanup for large ejected project

Once your project grows and ready to for your clients, chances are you are left with
humongous task of Tailwind CSS cleanup. I call this "ejected" states.

## In Action

```html
<div class="my-class border rounded-md px-4 py-2 bg-primary-100">
    <!-- -->
</div>
```

What if we can help you, if not a bit?

```html
<div class="my-class adkuioqa">
    <!-- -->
</div>
```

We'll cleanup your html files and organize the CSSes. You can then choose what to name them.

`adkuioqa = .btn`
```
<div class="my-class btn">
    <!-- -->
</div>
```

## Concept

This is currently in ideation, but me myself are eagerly waiting to try this myself.

I have a lot of codebases that needs cleanup! 🤯

## Contributing

Take a look into:
https://github.com/Xavier-IV/tail_draft/wiki/Developer


## Great alternative

There are some limited alternative that I'm aware of and are still searching:

- [Windi CSS Analyzer](https://windicss.org/features/analyzer.html) (Sunsetting)
- [Tailwind CSS Analysis](https://github.com/apvarun/tailwindcss-analysis)