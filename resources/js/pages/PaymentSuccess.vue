<script setup>
import AppLayout from '@/layouts/AppLayout.vue';
</script>

<template>
  <AppLayout>
    <div class="max-w-xl mx-auto p-8 text-center bg-white rounded-xl shadow-lg mt-16">
      <div class="flex flex-col items-center">
        <svg class="w-20 h-20 text-green-500 mb-6" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 48 48">
          <circle cx="24" cy="24" r="22" stroke="currentColor" stroke-opacity="0.2" fill="currentColor" fill-opacity="0.05"/>
          <path d="M16 24l6 6 10-12" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
        </svg>
        <h1 class="text-4xl font-extrabold text-green-600 mb-3">Payment Successful</h1>
        <p class="text-lg text-gray-700 mb-6">Thank you for your purchase! Your cart has been cleared.</p>
        <a href="/" class="inline-block px-6 py-2 bg-green-600 text-white rounded-lg shadow hover:bg-green-700 transition">Go to Home</a>
      </div>
    </div>
  </AppLayout>
</template>
