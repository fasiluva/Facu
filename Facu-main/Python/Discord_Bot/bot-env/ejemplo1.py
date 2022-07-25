# cd C:\Users\USUARIO\Documents\GitHub\Facu\Facu-main\Python\Discord_Bot\bot-env
# bot-env\Scripts\activate.bat 
# python3 -m venv bot-env

import discord
from discord.ext import commands
import logging

logger = logging.getLogger('discord')
logger.setLevel(logging.DEBUG)
handler = logging.FileHandler(filename='discord.log', encoding='utf-8', mode='w')
handler.setFormatter(logging.Formatter('%(asctime)s:%(levelname)s:%(name)s: %(message)s'))
logger.addHandler(handler)

client = discord.Client() #Conexion con DS

@client.event #regitra un evento
async def on_ready(): #cuando el bot loggea
    print('We have logged in as {0.user}'.format(client))

@bot.command()
async def test(ctx, arg):
    await ctx.send(arg)

@client.event
async def on_message(message): #cuando recibe un mensaje
    if message.author == client.user: #ignora los mensajes del propio bot
        return

    if message.content.startswith('ete sech'): #si el mensaje empieza asi, reponde
        await message.channel.send('El pepe') # hello!

client.run('MTAwMDQ5Njk1OTgxNzI3MzQyOA.G5ZFTB.dMK07PVVdyOhkH-jZnXqm0yc7mQi7fN2BDPTbI') #token del bot 

#MTAwMDQ5Njk1OTgxNzI3MzQyOA.G5ZFTB.dMK07PVVdyOhkH-jZnXqm0yc7mQi7fN2BDPTbI

