# Generated by Django 3.2.5 on 2021-09-20 13:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('config', '0008_camera_lastvalue'),
    ]

    operations = [
        migrations.AddField(
            model_name='imagem',
            name='garrafas',
            field=models.IntegerField(default=0, verbose_name='Garrafas Presentes'),
        ),
    ]
