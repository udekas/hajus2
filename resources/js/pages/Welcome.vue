<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3';
</script>

<template>
    <Head title="Welcome">
        <link rel="preconnect" href="https://rsms.me/" />
        <link rel="stylesheet" href="https://rsms.me/inter/inter.css" />
    </Head>
    <div class="flex min-h-screen flex-col items-center bg-gradient-to-br from-[#fdf6e3] via-[#fdfdfc] to-[#ffe3e3] p-6 text-[#1b1b18] dark:bg-gradient-to-br dark:from-[#0a0a0a] dark:via-[#161615] dark:to-[#1D0002] lg:justify-center lg:p-8 font-sans">
        <header class="mb-8 w-full max-w-[335px] text-sm lg:max-w-4xl">
            <nav class="flex items-center justify-end gap-4">
                <Link
                    v-if="$page.props.auth.user"
                    :href="route('dashboard')"
                    class="inline-block rounded-md border border-[#f53003] bg-[#f53003] px-5 py-2 text-sm font-semibold text-white shadow hover:bg-[#d42a00] transition dark:border-[#FF4433] dark:bg-[#FF4433] dark:hover:bg-[#d42a00]"
                >
                    Dashboard
                </Link>
                <template v-else>
                    <Link
                        :href="route('login')"
                        class="inline-block rounded-md border border-[#f53003] px-5 py-2 text-sm font-semibold text-[#f53003] bg-white shadow hover:bg-[#f53003] hover:text-white transition dark:border-[#FF4433] dark:text-[#FF4433] dark:hover:bg-[#FF4433] dark:hover:text-white"
                    >
                        Log in
                    </Link>
                    <Link
                        :href="route('register')"
                        class="inline-block rounded-md border border-[#f53003] px-5 py-2 text-sm font-semibold text-[#f53003] bg-white shadow hover:bg-[#f53003] hover:text-white transition dark:border-[#FF4433] dark:text-[#FF4433] dark:hover:bg-[#FF4433] dark:hover:text-white"
                    >
                        Register
                    </Link>
                </template>
            </nav>
        </header>
        <div class="flex w-full items-center justify-center transition-opacity duration-700 lg:grow">
            <main class="flex w-full max-w-[335px] flex-col-reverse overflow-hidden rounded-2xl shadow-xl bg-white/80 backdrop-blur-lg lg:max-w-4xl lg:flex-row dark:bg-[#161615]/90">
                <div
                    class="flex-1 rounded-bl-2xl rounded-br-2xl bg-white/90 p-8 pb-14 text-[15px] leading-[22px] shadow-inner dark:bg-[#161615]/90 dark:text-[#EDEDEC] lg:rounded-br-none lg:rounded-tl-2xl lg:p-20"
                >
                    <h1 class="mb-2 text-3xl font-bold text-[#f53003] dark:text-[#FF4433]">Let's get started</h1>
                    <p class="mb-4 text-[#706f6c] dark:text-[#A1A09A] text-lg">
                        Laravel has an incredibly rich ecosystem.<br />We suggest starting with the following.
                    </p>
                    <ul class="mb-6 flex flex-col gap-2">
                        <li class="relative flex items-center gap-4 py-2">
                            <span class="relative bg-white py-1 dark:bg-[#161615]">
                                <span class="flex h-4 w-4 items-center justify-center rounded-full border-2 border-[#f53003] bg-[#fff6f3] shadow dark:border-[#FF4433] dark:bg-[#1D0002]">
                                    <span class="h-2 w-2 rounded-full bg-[#f53003] dark:bg-[#FF4433]" />
                                </span>
                            </span>
                            <span>
                                Read the
                                <a
                                    href="https://laravel.com/docs"
                                    target="_blank"
                                    class="ml-1 inline-flex items-center space-x-1 font-semibold text-[#f53003] underline underline-offset-4 hover:text-[#d42a00] dark:text-[#FF4433] dark:hover:text-[#d42a00]"
                                >
                                    <span>Documentation</span>
                                    <svg width="12" height="13" viewBox="0 0 10 11" fill="none" xmlns="http://www.w3.org/2000/svg" class="h-3 w-3">
                                        <path d="M7.70833 6.95834V2.79167H3.54167M2.5 8L7.5 3.00001" stroke="currentColor" stroke-linecap="square" />
                                    </svg>
                                </a>
                            </span>
                        </li>
                        <li class="relative flex items-center gap-4 py-2">
                            <span class="relative bg-white py-1 dark:bg-[#161615]">
                                <span class="flex h-4 w-4 items-center justify-center rounded-full border-2 border-[#f53003] bg-[#fff6f3] shadow dark:border-[#FF4433] dark:bg-[#1D0002]">
                                    <span class="h-2 w-2 rounded-full bg-[#f53003] dark:bg-[#FF4433]" />
                                </span>
                            </span>
                            <span>
                                Watch video tutorials at
                                <a
                                    href="https://laracasts.com"
                                    target="_blank"
                                    class="ml-1 inline-flex items-center space-x-1 font-semibold text-[#f53003] underline underline-offset-4 hover:text-[#d42a00] dark:text-[#FF4433] dark:hover:text-[#d42a00]"
                                >
                                    <span>Laracasts</span>
                                    <svg width="12" height="13" viewBox="0 0 10 11" fill="none" xmlns="http://www.w3.org/2000/svg" class="h-3 w-3">
                                        <path d="M7.70833 6.95834V2.79167H3.54167M2.5 8L7.5 3.00001" stroke="currentColor" stroke-linecap="square" />
                                    </svg>
                                </a>
                            </span>
                        </li>
                    </ul>
                    <ul class="flex gap-3 text-sm leading-normal">
                        <li>
                            <a
                                href="https://cloud.laravel.com"
                                target="_blank"
                                class="inline-block rounded-md border border-[#f53003] bg-gradient-to-r from-[#f53003] to-[#FF4433] px-6 py-2 text-base font-semibold text-white shadow-lg hover:from-[#d42a00] hover:to-[#f53003] transition dark:border-[#FF4433]"
                            >
                                🚀 Deploy now
                            </a>
                        </li>
                    </ul>
                </div>
                <div
                    class="relative -mb-px aspect-[335/376] w-full shrink-0 overflow-hidden rounded-t-2xl bg-[#fff2f2] dark:bg-[#1D0002] lg:-ml-px lg:mb-0 lg:aspect-auto lg:w-[438px] lg:rounded-r-2xl lg:rounded-t-none flex items-center justify-center"
                >
                    <svg
                        class="w-full max-w-none text-[#F53003] dark:text-[#F61500] animate-fadeIn"
                        viewBox="0 0 438 104"
                        fill="none"
                        xmlns="http://www.w3.org/2000/svg"
                    >
                        <!-- SVG content unchanged -->
                        <path d="M17.2036 -3H0V102.197H49.5189V86.7187H17.2036V-3Z" fill="currentColor" />
                        <!-- ... rest of SVG ... -->
                    </svg>
                    <div
                        class="absolute inset-0 rounded-t-2xl shadow-[inset_0px_0px_0px_2px_rgba(245,48,3,0.08)] dark:shadow-[inset_0px_0px_0px_2px_#FF443355] lg:overflow-hidden lg:rounded-r-2xl lg:rounded-t-none pointer-events-none"
                    />
                </div>
            </main>
        </div>
        <footer class="mt-10 text-center text-xs text-[#a1a09a] dark:text-[#706f6c]">
            Made with <span class="text-[#f53003] dark:text-[#FF4433]">♥</span> using Laravel &amp; Vue
        </footer>
    </div>
</template>
