import requests


def main():
    req = requests.get('https://www.apache.org/dyn/closer.cgi?filename=activemq/activemq-artemis/2.32.0/apache-artemis-2.32.0-bin.tar.gz&action=download', stream=True)
    f = open('./activemq-ar.tar.gz', 'wb')
    total_copied = 0
    for chunk in req.iter_content(chunk_size=1024*1024):
        if chunk:
            f.write(chunk)
            total_copied += len(chunk)
    f.close()
    req.close()

if __name__ == '__main__':
    main()
