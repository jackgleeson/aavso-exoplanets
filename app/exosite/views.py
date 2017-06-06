from django.http import HttpResponseRedirect, HttpResponse
from django.shortcuts import render
from .forms import UploadFileForm
from .models import *

import pprint


def year_archive(request, year):
    report_list = Report.objects.filter(pub_date__year=year)
    context = {'year': year, 'report_list': report_list}
    return render(request, 'report/year_archive.html', context)


def upload_file(request):
    if request.method == 'POST':
        form = UploadFileForm(request.POST, request.FILES)
        if form.is_valid():

            # save image file
            f = request.FILES['image']
            with open('../files/' + f.name, 'wb+') as destination:
                for chunk in f.chunks():
                    destination.write(chunk)

            # load report file
            file_data = request.FILES['report'].read().decode()  # this needs to be chunked

            # process ascii table
            ascii_report = AsciiFileReportParser(file_data)

            return HttpResponse(pprint.pformat(ascii_report.get_properties()))
            # return HttpResponseRedirect('/upload/success')
        else:
            return HttpResponse(pprint.pformat(form.errors))
    else:
        form = UploadFileForm()
    return render(request, 'upload/upload.html', {'form': form})


def success(request):
    return render(request, 'upload/success.html')
